Return-Path: <SRS0=wsBa=SO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC874C10F0E
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Apr 2019 14:44:27 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8FB8620675
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Apr 2019 14:44:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8FB8620675
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:38193 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hExPm-0004wH-M3
	for qemu-devel@archiver.kernel.org; Fri, 12 Apr 2019 10:44:26 -0400
Received: from eggs.gnu.org ([209.51.188.92]:53605)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1hExOo-0004Wa-Oe
	for qemu-devel@nongnu.org; Fri, 12 Apr 2019 10:43:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1hExOm-0003MC-Qw
	for qemu-devel@nongnu.org; Fri, 12 Apr 2019 10:43:26 -0400
Received: from mx1.redhat.com ([209.132.183.28]:50758)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1hExOk-0003KH-Qs
	for qemu-devel@nongnu.org; Fri, 12 Apr 2019 10:43:24 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
	[10.5.11.13])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 1C7F0306540D;
	Fri, 12 Apr 2019 14:43:19 +0000 (UTC)
Received: from thuth.remote.csb (ovpn-116-133.ams2.redhat.com [10.36.116.133])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 3D468608E1;
	Fri, 12 Apr 2019 14:42:45 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
	=?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>,
	Markus Armbruster <armbru@redhat.com>
References: <87d0mwatbu.fsf@dusky.pond.sub.org>
	<CAAdtpL6VCiXLbTWyJo4cbCNLjOCPr6KrH8KTqEq1V=CTMYKubQ@mail.gmail.com>
	<6fe1a987-c3c5-3af5-74a4-fc4cd08d2380@redhat.com>
	<2056cff2-78f8-1079-8d05-e758971d73ec@redhat.com>
	<045d5528-116e-c71d-c29b-c070b7f660e3@redhat.com>
Openpgp: preference=signencrypt
Autocrypt: addr=thuth@redhat.com; keydata=
	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
Organization: Red Hat
Message-ID: <72abd5d6-86ce-3f8f-cbda-69250f4a0292@redhat.com>
Date: Fri, 12 Apr 2019 16:42:43 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <045d5528-116e-c71d-c29b-c070b7f660e3@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.40]);
	Fri, 12 Apr 2019 14:43:21 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] Maintainers,
 please tell us how to boot your machines!
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: Paul Burton <pburton@wavecomp.com>, Cornelia Huck <cohuck@redhat.com>,
	Sagar Karandikar <sagark@eecs.berkeley.edu>,
	"Michael S. Tsirkin" <mst@redhat.com>, Andrew Jeffery <andrew@aj.id.au>,
	Anthony Green <green@moxielogic.com>, Palmer Dabbelt <palmer@sifive.com>,
	Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
	"qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>,
	Max Filippov <jcmvbkbc@gmail.com>,
	Alistair Francis <Alistair.Francis@wdc.com>,
	"Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
	Guan Xuetao <gxt@mprc.pku.edu.cn>, Peter Chubb <peter.chubb@nicta.com.au>,
	Marek Vasut <marex@denx.de>, Rob Herring <robh@kernel.org>,
	Stefano Stabellini <sstabellini@kernel.org>, Jia Liu <proljc@gmail.com>,
	Peter Maydell <peter.maydell@linaro.org>, Helge Deller <deller@gmx.de>,
	David Hildenbrand <david@redhat.com>, Magnus Damm <magnus.damm@gmail.com>,
	Halil Pasic <pasic@linux.ibm.com>,
	Christian Borntraeger <borntraeger@de.ibm.com>,
	=?UTF-8?Q?Herv=c3=a9_Poussineau?= <hpoussin@reactos.org>,
	Antony Pavlov <antonynpavlov@gmail.com>,
	Anthony Perard <anthony.perard@citrix.com>,
	David Gibson <david@gibson.dropbear.id.au>,
	Artyom Tarasenko <atar4qemu@gmail.com>, Joel Stanley <joel@jms.id.au>,
	Eduardo Habkost <ehabkost@redhat.com>,
	Jean-Christophe Dubois <jcd@tribudubois.net>,
	Alistair Francis <alistair@alistair23.me>,
	Fabien Chouteau <chouteau@adacore.com>,
	Beniamino Galvani <b.galvani@gmail.com>,
	Paul Durrant <paul.durrant@citrix.com>, Jan Kiszka <jan.kiszka@web.de>,
	=?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>,
	Stafford Horne <shorne@gmail.com>,
	Andrey Smirnov <andrew.smirnov@gmail.com>,
	Richard Henderson <rth@twiddle.net>,
	Igor Mitsyanko <i.mitsyanko@gmail.com>,
	Bastian Koppelmann <kbastian@mail.uni-paderborn.de>,
	Chris Wulff <crwulff@gmail.com>,
	Andrew Baumann <Andrew.Baumann@microsoft.com>,
	Subbaraya Sundeep <sundeep.lkml@gmail.com>,
	Aleksandar Rikalo <arikalo@wavecomp.com>, Michael Walle <michael@walle.cc>,
	Thomas Huth <huth@tuxfamily.org>,
	Aleksandar Markovic <amarkovic@wavecomp.com>,
	Paolo Bonzini <pbonzini@redhat.com>, Aurelien Jarno <aurelien@aurel32.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190412144243.-EAqrrdbNONRfTUYMTY1ike8uJ2wHaU7aDPmf0S0gB4@z>

On 12/04/2019 14.12, Thomas Huth wrote:
> On 12/04/2019 13.28, Philippe Mathieu-Daud=C3=A9 wrote:
>> On 4/12/19 1:11 PM, Thomas Huth wrote:
>>> On 13/03/2019 02.06, Philippe Mathieu-Daud=C3=A9 wrote:
>>>> '
>>>> On Tue, Mar 12, 2019 at 6:44 PM Markus Armbruster <armbru@redhat.com=
> wrote:
>>> [...]
>>>>>     =3D hw/arm/nseries.c =3D
>>>>>     Andrzej Zaborowski <balrogg@gmail.com> (odd fixer:nSeries)
>>>>>     Peter Maydell <peter.maydell@linaro.org> (odd fixer:nSeries)
>>>>>     qemu-arm@nongnu.org (open list:nSeries)
>>>>
>>>> images:
>>>> http://stskeeps.subnetmask.net/meego-n8x0/
>>>>
>>>> $ qemu-system-arm -M n810 -kernel
>>>> meego-arm-n8x0-1.0.80.20100712.1431-vmlinuz-2.6.35~rc4-129.1-n8x0
>>>> -append "root=3D/dev/mmcblk0p1 console=3DttyS0 printk.time=3D0 rootw=
ait" -m
>>>> 130 -sd meego-arm-n8x0-1.0.80.20100712.1431-sda.raw -serial stdio
>>>
>>> That does not work for me - I only get a white screen that turns to
>>> black after half a second, and no output (also not on the serial
>>> console). Does it still work for you with the latest QEMU master bran=
ch?
>>
>> It is broken since a long time. I guess rememember some irc chat about
>> it previous to v2.9.0, then I added this line to my TODO "this command
>> used to work, see what's wrong here". I never bisected to figure out
>> since when it got bitroted.
>=20
> Ok, thanks, good to know. I was just thinking about deprecating this
> machine, since it uses the already deprecated bluetooth subsystem, and
> we likely can not remove bluetooth without removing this machine, too.
> So if it is already broken, that's another reason for really deprecatin=
g
> this machine now.

Ah, well, the kernel still boots if I remove the "console=3DttyS0" from
the argument list... so it is not completely broken yet.

 Thomas

