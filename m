Return-Path: <SRS0=DspQ=T5=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4606EC28CC0
	for <qemu-devel@archiver.kernel.org>; Wed, 29 May 2019 13:21:47 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1CE87205F4
	for <qemu-devel@archiver.kernel.org>; Wed, 29 May 2019 13:21:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1CE87205F4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:54264 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hVyWY-0000Db-4W
	for qemu-devel@archiver.kernel.org; Wed, 29 May 2019 09:21:46 -0400
Received: from eggs.gnu.org ([209.51.188.92]:42096)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1hVyV8-0007v3-OU
	for qemu-devel@nongnu.org; Wed, 29 May 2019 09:20:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1hVyV7-00074g-UP
	for qemu-devel@nongnu.org; Wed, 29 May 2019 09:20:18 -0400
Received: from mail-wm1-f41.google.com ([209.85.128.41]:38222)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1hVyV7-000744-PI
	for qemu-devel@nongnu.org; Wed, 29 May 2019 09:20:17 -0400
Received: by mail-wm1-f41.google.com with SMTP id t5so1602868wmh.3
	for <qemu-devel@nongnu.org>; Wed, 29 May 2019 06:20:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
	:date:user-agent:mime-version:in-reply-to:content-language
	:content-transfer-encoding;
	bh=YnIcyWSlxmwHrQOxn7L+/vGM87xN2qYHeBQs7WFqtHg=;
	b=M+6mYH4w8ECvOf6+z8kAqCUCSQNbxEJ/s/vCe6JslfUnSgock3qUKJoz6cjkQuYLXY
	aVYjXBn6LJtgkjiva4lQ/kFqMiE4vqFerAkRER/o1z5JiBtvEVV4PJg69cDZJwpmJEpo
	Cs2S+oHBWJZA2kmxccMPZgRPLvRv3jj7oOJFXOq+Jpsu1aJ75T/j8PohpoTEpOGnJmpH
	VKuHauaEw2d8uP6uK1aHeDj0JkxaHlNTeJ5F0LEz7vNeCwxTkdM/8Z8f94QmdJ/Uuw9t
	++3fFesM5WdomgP1VhozUmIXi5Ju0en4b9a8ToAmDrZSR046upuoG7PBMdi/IDRTXMAT
	h/pQ==
X-Gm-Message-State: APjAAAUaiJKGNnMidDn3bHpJosim2YpW3Re0FUViBThyjJUsLrX2Ge+m
	qHOXmTAYy2V39XmlKEj7JkNi3w==
X-Google-Smtp-Source: APXvYqz4kNYSqSZlAdO5JDYpDqVpd6Go61fFpe15p8jtMoAW5LGz/l7z3wqwxfGQXWOEeKjNltdAow==
X-Received: by 2002:a7b:cbd8:: with SMTP id n24mr6806538wmi.2.1559136015521;
	Wed, 29 May 2019 06:20:15 -0700 (PDT)
Received: from [10.32.224.40] (red-hat-inc.vlan560.asr1.mad1.gblx.net.
	[159.63.51.90]) by smtp.gmail.com with ESMTPSA id
	205sm6973253wmd.43.2019.05.29.06.20.11
	(version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
	Wed, 29 May 2019 06:20:14 -0700 (PDT)
To: Markus Armbruster <armbru@redhat.com>, Max Filippov <jcmvbkbc@gmail.com>
References: <87lfyqla7r.fsf@dusky.pond.sub.org>
	<CAMo8BfKKGgLnw5DxXs=1Mh3EyenyzJxait4Ds9F7d3Y7843QnA@mail.gmail.com>
	<87ftoxfmpz.fsf@dusky.pond.sub.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Openpgp: id=89C1E78F601EE86C867495CBA2A3FD6EDEADC0DE;
	url=http://pgp.mit.edu/pks/lookup?op=get&search=0xA2A3FD6EDEADC0DE
Message-ID: <e6c16333-ae32-a30c-ec99-a4145a3f30b2@redhat.com>
Date: Wed, 29 May 2019 15:20:10 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <87ftoxfmpz.fsf@dusky.pond.sub.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
	[fuzzy]
X-Received-From: 209.85.128.41
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
	Dmitry Fleytman <dmitry.fleytman@gmail.com>,
	Sagar Karandikar <sagark@eecs.berkeley.edu>,
	"Michael S. Tsirkin" <mst@redhat.com>, James Hogan <jhogan@kernel.org>,
	Anthony Green <green@moxielogic.com>, Palmer Dabbelt <palmer@sifive.com>,
	Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
	qemu-devel <qemu-devel@nongnu.org>,
	=?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>,
	Alistair Francis <Alistair.Francis@wdc.com>,
	Gerd Hoffmann <kraxel@redhat.com>,
	"Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
	Guan Xuetao <gxt@mprc.pku.edu.cn>, Marek Vasut <marex@denx.de>,
	Stefano Stabellini <sstabellini@kernel.org>,
	Aleksandar Rikalo <arikalo@wavecomp.com>, Helge Deller <deller@gmx.de>,
	David Hildenbrand <david@redhat.com>, Halil Pasic <pasic@linux.ibm.com>,
	Christian Borntraeger <borntraeger@de.ibm.com>,
	Anthony Perard <anthony.perard@citrix.com>,
	David Gibson <david@gibson.dropbear.id.au>,
	Laszlo Ersek <lersek@redhat.com>, Jason Wang <jasowang@redhat.com>,
	Artyom Tarasenko <atar4qemu@gmail.com>,
	Laurent Vivier <lvivier@redhat.com>, Thomas Huth <thuth@redhat.com>,
	Alistair Francis <alistair@alistair23.me>,
	Eduardo Habkost <ehabkost@redhat.com>,
	Riku Voipio <riku.voipio@iki.fi>, Greg Kurz <groug@kaod.org>,
	Marcelo Tosatti <mtosatti@redhat.com>,
	Beniamino Galvani <b.galvani@gmail.com>,
	Eric Auger <eric.auger@redhat.com>, Paul Durrant <paul.durrant@citrix.com>,
	Stafford Horne <shorne@gmail.com>,
	=?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
	Richard Henderson <rth@twiddle.net>,
	"Daniel P. Berrange" <berrange@redhat.com>,
	Claudio Fontana <claudio.fontana@gmail.com>,
	Bastian Koppelmann <kbastian@mail.uni-paderborn.de>,
	Chris Wulff <crwulff@gmail.com>,
	Claudio Fontana <claudio.fontana@huawei.com>,
	Laurent Vivier <laurent@vivier.eu>,
	Andrew Baumann <Andrew.Baumann@microsoft.com>,
	Michael Walle <michael@walle.cc>,
	Aleksandar Markovic <amarkovic@wavecomp.com>,
	Cornelia Huck <cohuck@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
	Aurelien Jarno <aurelien@aurel32.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 5/29/19 2:51 PM, Markus Armbruster wrote:
> Max Filippov <jcmvbkbc@gmail.com> writes:
> 
>> On Tue, May 28, 2019 at 11:12 AM Markus Armbruster <armbru@redhat.com> wrote:
>>> target/xtensa/helper.h
>> Intentional.
>>
>>> target/xtensa/overlay_tool.h
>> Unintentional.
>>
>>> target/xtensa/xtensa-isa.h
>> It's a one-liner that includes another header.
> 
> Feels like a bad idea, but it doesn't bother me right now.

I think include/hw/xtensa/xtensa-isa.h is misplaced, it should be in
target/xtensa/xtensa-isa.h, but since disas/xtensa.c includes it, it
ended in include/.

