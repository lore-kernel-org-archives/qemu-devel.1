Return-Path: <SRS0=3v23=UE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0ECAC28CC5
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Jun 2019 16:21:24 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CE3B0206C3
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Jun 2019 16:21:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CE3B0206C3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:45881 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hYYfE-0005sO-4S
	for qemu-devel@archiver.kernel.org; Wed, 05 Jun 2019 12:21:24 -0400
Received: from eggs.gnu.org ([209.51.188.92]:35391)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <lersek@redhat.com>) id 1hYYe5-0005Be-0d
	for qemu-devel@nongnu.org; Wed, 05 Jun 2019 12:20:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <lersek@redhat.com>) id 1hYYe4-0003dd-18
	for qemu-devel@nongnu.org; Wed, 05 Jun 2019 12:20:13 -0400
Received: from mx1.redhat.com ([209.132.183.28]:53652)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <lersek@redhat.com>) id 1hYYe3-0003WY-Py
	for qemu-devel@nongnu.org; Wed, 05 Jun 2019 12:20:11 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
	[10.5.11.13])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 5C8A730C252E;
	Wed,  5 Jun 2019 16:19:25 +0000 (UTC)
Received: from lacos-laptop-7.usersys.redhat.com (ovpn-116-187.ams2.redhat.com
	[10.36.116.187])
	by smtp.corp.redhat.com (Postfix) with ESMTP id CCFD45F7C0;
	Wed,  5 Jun 2019 16:18:39 +0000 (UTC)
To: =?UTF-8?Q?Daniel_P._Berrang=c3=a9?= <berrange@redhat.com>,
	Markus Armbruster <armbru@redhat.com>
References: <87lfyqla7r.fsf@dusky.pond.sub.org>
	<20190605142300.GB8956@redhat.com>
From: Laszlo Ersek <lersek@redhat.com>
Message-ID: <a6739318-7837-6273-7afa-b19f941ee8aa@redhat.com>
Date: Wed, 5 Jun 2019 18:18:38 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
	Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20190605142300.GB8956@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.40]);
	Wed, 05 Jun 2019 16:20:01 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] Headers without multiple inclusion guards
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
Cc: Peter Maydell <peter.maydell@linaro.org>, Chris Wulff <crwulff@gmail.com>,
	Sagar Karandikar <sagark@eecs.berkeley.edu>,
	David Hildenbrand <david@redhat.com>, James Hogan <jhogan@kernel.org>,
	Anthony Green <green@moxielogic.com>, Palmer Dabbelt <palmer@sifive.com>,
	Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
	qemu-devel@nongnu.org, Max Filippov <jcmvbkbc@gmail.com>,
	Dmitry Fleytman <dmitry.fleytman@gmail.com>,
	Alistair Francis <Alistair.Francis@wdc.com>,
	Gerd Hoffmann <kraxel@redhat.com>,
	"Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
	Guan Xuetao <gxt@mprc.pku.edu.cn>, Marek Vasut <marex@denx.de>,
	Stefano Stabellini <sstabellini@kernel.org>,
	Aleksandar Rikalo <arikalo@wavecomp.com>, Helge Deller <deller@gmx.de>,
	"Michael S. Tsirkin" <mst@redhat.com>, Halil Pasic <pasic@linux.ibm.com>,
	Christian Borntraeger <borntraeger@de.ibm.com>,
	Anthony Perard <anthony.perard@citrix.com>,
	Richard Henderson <rth@twiddle.net>, Jason Wang <jasowang@redhat.com>,
	Artyom Tarasenko <atar4qemu@gmail.com>,
	Laurent Vivier <lvivier@redhat.com>,
	Thomas Huth <thuth@redhat.com>, Riku Voipio <riku.voipio@iki.fi>,
	Eduardo Habkost <ehabkost@redhat.com>,
	Alistair Francis <alistair@alistair23.me>, Greg Kurz <groug@kaod.org>,
	Marcelo Tosatti <mtosatti@redhat.com>,
	Beniamino Galvani <b.galvani@gmail.com>,
	Eric Auger <eric.auger@redhat.com>, Paul Durrant <paul.durrant@citrix.com>,
	Stafford Horne <shorne@gmail.com>,
	=?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
	David Gibson <david@gibson.dropbear.id.au>,
	Claudio Fontana <claudio.fontana@gmail.com>,
	Bastian Koppelmann <kbastian@mail.uni-paderborn.de>,
	Cornelia Huck <cohuck@redhat.com>,
	Claudio Fontana <claudio.fontana@huawei.com>,
	Laurent Vivier <laurent@vivier.eu>,
	Andrew Baumann <Andrew.Baumann@microsoft.com>,
	=?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
	Michael Walle <michael@walle.cc>,
	Aleksandar Markovic <amarkovic@wavecomp.com>,
	Paolo Bonzini <pbonzini@redhat.com>, Aurelien Jarno <aurelien@aurel32.net>,
	=?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 06/05/19 16:23, Daniel P. Berrang=C3=A9 wrote:
> On Tue, May 28, 2019 at 08:12:24PM +0200, Markus Armbruster wrote:
>> We have a bunch of headers without multiple inclusion guards.  Some ar=
e
>> clearly intentional, some look accidental.  Too many for me to find ou=
t
>> by examining each of them, so I'm asking their maintainers.
>>
>> Why do I ask?  I'd like to mark the intentional ones and fix the
>> accidental ones, so they don't flunk "make check-headers" from "[RFC v=
4
>> 0/7] Baby steps towards saner headers" just because they lack multiple
>> inclusion guards.
>>
>> Just in case: what's a multiple inclusion guard?  It's
>>
>>     #ifndef UNIQUE_GUARD_SYMBOL_H
>>     #define UNIQUE_GUARD_SYMBOL_H
>>     ...
>>     #endif
>>
>> with nothing but comments outside the conditional, so that the header
>> can safely be included more than once.
>=20
> Any opinions on using the less verbose syntax instead:
>=20
>   #pragma once
>=20
> It is not portable C, but we explicitly only care about GCC or CLang,
> so portability isn't an issue for us.

I don't feel strongly about this particular question, so if folks prefer
"#pragma once", I won't complain. I'd just like to report that section 6
of "HACKING" appears the opposite of "we explicitly only care about GCC
or CLang".

Thanks,
Laszlo

>=20
>=20
>> Cryptography
>> M: Daniel P. Berrange <berrange@redhat.com>
>> crypto/ivgen-essiv.h
>> crypto/ivgen-plain.h
>> crypto/ivgen-plain64.h
>=20
> These have header guards present
>=20
>> tests/crypto-tls-psk-helpers.h
>> tests/crypto-tls-x509-helpers.h
>=20
> These should be fixed.
>=20
> Regards,
> Daniel
>=20


