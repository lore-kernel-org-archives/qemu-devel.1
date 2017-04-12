Received: from eggs.gnu.org ([2001:4830:134:3::10]:54248)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mdroth@linux.vnet.ibm.com>) id 1cyOVx-0008TY-OZ
	for qemu-devel@nongnu.org; Wed, 12 Apr 2017 16:05:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mdroth@linux.vnet.ibm.com>) id 1cyOVs-0002iP-P5
	for qemu-devel@nongnu.org; Wed, 12 Apr 2017 16:05:17 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:33525
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mdroth@linux.vnet.ibm.com>)
	id 1cyOVs-0002hu-JY
	for qemu-devel@nongnu.org; Wed, 12 Apr 2017 16:05:12 -0400
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
	v3CK3s9x114363
	for <qemu-devel@nongnu.org>; Wed, 12 Apr 2017 16:05:11 -0400
Received: from e34.co.us.ibm.com (e34.co.us.ibm.com [32.97.110.152])
	by mx0a-001b2d01.pphosted.com with ESMTP id 29sne81csq-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Wed, 12 Apr 2017 16:05:10 -0400
Received: from localhost
	by e34.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <mdroth@linux.vnet.ibm.com>;
	Wed, 12 Apr 2017 14:05:10 -0600
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
From: Michael Roth <mdroth@linux.vnet.ibm.com>
References: <20170331101947.2046-1-vfeenstr@redhat.com>
	<20170331101947.2046-2-vfeenstr@redhat.com>
	<e60c94da-f3d8-3139-27c5-2c357b37834b@redhat.com>
	<CAJ+F1CL+jkWOdCeDkfBUBFssR41kT9uumVYrcjqeuQ7YvNX5fg@mail.gmail.com>
In-Reply-To: <CAJ+F1CL+jkWOdCeDkfBUBFssR41kT9uumVYrcjqeuQ7YvNX5fg@mail.gmail.com>
Date: Wed, 12 Apr 2017 15:05:02 -0500
Message-Id: <149202750217.22939.16193629731178448080@loki>
Subject: Re: [Qemu-devel] [PATCH v3] qemu-ga: add guest-get-osrelease command
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@gmail.com>, Eric Blake <eblake@redhat.com>, Vinzenz 'evilissimo' Feenstra <vfeenstr@redhat.com>, qemu-devel@nongnu.org

On 04/03/2017 10:17 AM, Marc-Andr=C3=A9 Lureau wrote:
> Hi
> =

> On Fri, Mar 31, 2017 at 3:41 PM Eric Blake <eblake@redhat.com> wrote:
> =

>> On 03/31/2017 05:19 AM, Vinzenz 'evilissimo' Feenstra wrote:
>>> From: Vinzenz Feenstra <vfeenstr@redhat.com>
>>>
>>> Add a new 'guest-get-osrelease' command to report OS information in
>>> the
>>> os-release format. As documented here:
>>> https://www.freedesktop.org/software/systemd/man/os-release.html
>>>
>>> The win32 implementation generates the information.
>>> On POSIX systems the /etc/os-release or /usr/lib/os-release files
>>> content is returned when available and gets extended with the
>>> fields:
>>> - QGA_UNAME_RELEASE which is the content of `uname -r`
>>> - QGA_UNAME_VERSION which is the content of `uname -v`
>>> - QGA_UNAME_MACHINE which is the content of `uname -m`
>>>
>>> Here an example for a Fedora 25 VM:
>>>
>>> virsh # qemu-agent-command F25 '{ "execute": "guest-get-osrelease"
>>> }'
>>> {"return":{"content":"NAME=3DFedora\nVERSION=3D\"25 (Server Edition)\"\n
>>> ID=3Dfedora\nVERSION_ID=3D25\nPRETTY_NAME=3D\"Fedora 25 (Server
>>> Edition)\"\n
>>> ANSI_COLOR=3D\"0;34\"\nCPE_NAME=3D\"cpe:/o:fedoraproject:fedora:25\"\n
>>> HOME_URL=3D\"https://fedoraproject.org/\"\n
>>> BUG_REPORT_URL=3D\"https://bugzilla.redhat.com/\"\n
>>> REDHAT_BUGZILLA_PRODUCT=3D\"Fedora\"\n
>>> REDHAT_BUGZILLA_PRODUCT_VERSION=3D25\nREDHAT_SUPPORT_PRODUCT=3D\"Fedora=
\"\n
>>> REDHAT_SUPPORT_PRODUCT_VERSION=3D25\n
>>> PRIVACY_POLICY_URL=3Dhttps://fedoraproject.org/wiki/Legal:PrivacyPolicy=
\n
>>> VARIANT=3D\"Server Edition\"\nVARIANT_ID=3Dserver\n\n
>>> QGA_UNAME_RELEASE=3D\"4.8.6-300.fc25.x86_64\"\n
>>> QGA_UNAME_VERSION=3D\"#1 SMP Tue Nov 1 12:36:38 UTC 2016\"\n
>>> QGA_UNAME_MACHINE=3D\"x86_64\"\n"}}
>>
>> Uggh. This is a step backwards.  Now you are requiring the end user
>> to
>> parse a raw string, instead of giving them the information already
>> broken out as a JSON dictionary.
>>
> =

> yes otoh, it uses an existing standard to retrieve various guest os
> release
> informations, which existing tool may know how to handle.
> =

> (I feel partially guilty about it since I suggested it, mainly in a
> discussion over irc and Vinzenz adopted it)
> =

> The format is fairly straightforward to parse, but perhaps it should
> be
> sent as a JSON dict instead? However, that would mean that the list of
> keys
> is limited by what QGA protocol defines, and the agent would have to
> parse
> the file himself. And we would have to duplicate the documentation
> etc..
> =

> I would rely on the XDG format instead, given its simplicity,
> extensibility
> and documentation that fits the job nicely imho.

I like the idea of using an existing standard, but if they really want
to get at a raw dump of /etc/os-release to use with existing tools then
I think guest-file-open/read are the more appropriate interfaces.

Knowing that they *can* get at information like that for a particular
guest, or do things like execute 'uname -m' via guest-exec, is where I
think an interface like this has it's place.

So I think a more curated/limited set of identifiers is sufficient, and
still flexible enough to enable to more os-specific use-cases.

But I also don't like the idea of re-defining what terms like
"version_id", "variant", "varient_id", etc mean, so I think it's still
a good idea to use the os-release-documented fields as the basis for
the fields we decide to return in our dictionary, and note that
explicitly in the schema documentation.
