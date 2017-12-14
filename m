Received: from eggs.gnu.org ([2001:4830:134:3::10]:34398)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1ePQ10-0004aN-4J
	for qemu-devel@nongnu.org; Thu, 14 Dec 2017 04:41:19 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1ePQ0x-0002qZ-0l
	for qemu-devel@nongnu.org; Thu, 14 Dec 2017 04:41:18 -0500
Received: from mx1.redhat.com ([209.132.183.28]:53884)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1ePQ0w-0002pV-RE
	for qemu-devel@nongnu.org; Thu, 14 Dec 2017 04:41:14 -0500
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
	[10.5.11.16])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 94CF9356D0
	for <qemu-devel@nongnu.org>; Thu, 14 Dec 2017 09:41:13 +0000 (UTC)
References: <20171208115834.21577-1-berrange@redhat.com>
	<8e85e5e6-01f6-9c01-f7fa-e33ec4f9d6c7@redhat.com>
	<20171212141749.GC26971@redhat.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <54f33ad4-4483-9f92-ff24-9e6d1f4daf2a@redhat.com>
Date: Thu, 14 Dec 2017 10:41:09 +0100
MIME-Version: 1.0
In-Reply-To: <20171212141749.GC26971@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] docs: update information for TLS
 certificate management
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Daniel P. Berrange" <berrange@redhat.com>, Eric Blake <eblake@redhat.com>
Cc: qemu-devel@nongnu.org

On 12.12.2017 15:17, Daniel P. Berrange wrote:
> On Fri, Dec 08, 2017 at 10:16:50AM -0600, Eric Blake wrote:
>> On 12/08/2017 05:58 AM, Daniel P. Berrange wrote:
[...]
>>> +
>>> +@node tls_creds_setup
>>> +@subsection TLS x509 credential configuration
>>> +
>>> +QEMU has a standard mechanism for loading x509 credentials that will=
 be
>>> +used for network services and clients. It requires specifying the
>>> +@code{tls-creds-x509} class name to the @code{-object} command line
>>> +argument for the system emulators. This also works for the helper to=
ols
>>> +like @code{qemu-nbd} and @code{qemu-img}, but is named @code{--objec=
t}.
>>
>> You can use '--object' with qemu as well (getopt_long_only() accepts
>> double-dash form in addition to single dash).  If it makes it any easi=
er
>> to only document the double-dash form, then go for it.
>=20
> Since the QEMU -help text only mentions the single dash format, I'll
> stick with that.
>=20
> Perhaps though, we should change the -help text (and all docs) to alway=
s
> use double dash format so we're consistent across QEMU codebase, and mo=
re
> normal CLI arg syntax for long options ?

Good idea!

... and maybe we could also introduce some more short options for the
most popular parameters one day? A short option for "--device" would be
really handy, for example.

 Thomas
