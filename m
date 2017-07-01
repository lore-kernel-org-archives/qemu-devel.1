Received: from eggs.gnu.org ([2001:4830:134:3::10]:59601)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <sw@weilnetz.de>) id 1dRMIz-0002ld-B5
	for qemu-devel@nongnu.org; Sat, 01 Jul 2017 13:35:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <sw@weilnetz.de>) id 1dRMIw-0000bL-7e
	for qemu-devel@nongnu.org; Sat, 01 Jul 2017 13:35:37 -0400
Received: from mail.weilnetz.de ([37.120.169.71]:56334
	helo=v2201612906741603.powersrv.de)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <sw@weilnetz.de>) id 1dRMIw-0000a3-0c
	for qemu-devel@nongnu.org; Sat, 01 Jul 2017 13:35:34 -0400
References: <54F1DEE8.3010903@weilnetz.de>
	<20150302221228.GC4114@stefanha-thinkpad.redhat.com>
	<3763fa56-5bba-b060-6ee8-120c9cc50dbb@weilnetz.de>
	<20170123102810.GD29186@stefanha-x1.localdomain>
From: Stefan Weil <sw@weilnetz.de>
Message-ID: <c453070d-65d5-8a23-bdef-0fefbe9eb9b0@weilnetz.de>
Date: Sat, 1 Jul 2017 19:35:29 +0200
MIME-Version: 1.0
In-Reply-To: <20170123102810.GD29186@stefanha-x1.localdomain>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] QEMU website (wiki) improvements
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Hajnoczi <stefanha@gmail.com>
Cc: qemu-devel@nongnu.org, Michael Roth <mdroth@linux.vnet.ibm.com>

Am 23.01.2017 um 11:28 schrieb Stefan Hajnoczi:
> On Sun, Jan 22, 2017 at 04:19:43PM +0100, Stefan Weil wrote:
>> On 03/02/15 23:12, Stefan Hajnoczi wrote:
>>> On Sat, Feb 28, 2015 at 04:29:44PM +0100, Stefan Weil wrote:
>>>> * It does not support secure access (https), so each login is insecu=
re.
>>>>   Can we get a free server certificate?
>>>
>>> This is on my todo list.  I'm travelling right now but will work on i=
t
>>> over the coming weeks.
>>>
>>> There are some gotchas:
>>>
>>> 1. qemu.org vs qemu-project.org.  Unless we get a SNI certificate, th=
e
>>>    certificate will only be valid for one or the other.  Users will g=
et
>>>    an untrusted certificate message if they go to the other domain na=
me.
>>>
>>> 2. We use subdomains, so a wildcard certificate is necessary.  That's
>>>    not always offered for free so I need to compare the certificate
>>>    vendors.
>>>
>>> Stefan
>>
>>
>> Although this discussion thread is rather old, its subject
>> still applies.
>>
>> In the meantime there are free certificates available.
>> We could add https support with a certificate from
>> https://letsencrypt.org/. As long as there is only a
>> small number of host names (*), I'd simply add them all
>> to the primary certificate. In addition, SNI certificates
>> for the different names can be installed.
>=20
> Good idea, Jeff and I have discussed Let's Encrypt and have experience
> setting it up.
>=20
>> I can help with the installation if that is needed.
>>
>> Stefan
>>
>> (*)
>>
>> qemu.org
>> qemu.osuosl.org
>> qemu-project.org
>> wiki.qemu.org
>> wiki.qemu-project.org
>> www.qemu.org
>> www.qemu-project.org
>>
>> Are there more host names used?
>=20
> git.qemu.org
> git.qemu-project.org
>=20

It looks like there were some changes since my last mail:

The official website is now again www.qemu.org instead of
qemu-project.org. Is qemu-project.org now deprecated?

Also HTTPS was enabled, but uses a self signed certificate
and does not show the correct contents, so
https://www.qemu.org/ still does not work.

Stefan
