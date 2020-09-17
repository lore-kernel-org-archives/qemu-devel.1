Return-Path: <SRS0=BocF=C2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 954EFC2BBD1
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Sep 2020 08:08:20 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 28610221E7
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Sep 2020 08:08:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FNSk40xn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 28610221E7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46494 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kIoxn-0002Y7-79
	for qemu-devel@archiver.kernel.org; Thu, 17 Sep 2020 04:08:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52946)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xadimgnik@gmail.com>)
 id 1kIons-0004hA-0P; Thu, 17 Sep 2020 03:58:04 -0400
Received: from mail-wm1-x341.google.com ([2a00:1450:4864:20::341]:53485)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <xadimgnik@gmail.com>)
 id 1kIonp-0005yJ-2A; Thu, 17 Sep 2020 03:58:03 -0400
Received: by mail-wm1-x341.google.com with SMTP id x23so999544wmi.3;
 Thu, 17 Sep 2020 00:57:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:reply-to:to:cc:references:in-reply-to:subject:date:message-id
 :mime-version:content-transfer-encoding:content-language
 :thread-index; bh=F5tUFeKbpaEUrhow1U7w2I/lFPTZrbFATqkKv3cbFJA=;
 b=FNSk40xnigWgLlCaL62kHnc+P/yjp8QdcnH0aWaO96WYn0BmXic2joO/YFkThuDp4m
 gjGwwcqEO0+wPsVkP+Kv78yf9OIjYzMi88kt9zd/WrUMdtldCiDvzcoK4pTIbMfTaurL
 hjpUAji34/NkrNUAWEKQDPs8/MGafty1jcLdq6ZVTOouX5+NS7gKeW0YkOEdgIUZG7Fh
 Mmdh3S6nhYIVzKsTbpD3eCHB13hvKV6FRo7HTNrkU2pyGy2weIaKXKxC9vCF2qNpNJQh
 LtSUJD8k7S9juvysgja6hanFQKMglfE6PTxmx80iyLzWhPZeUndH30FwDZHOLlG9Hc51
 qQHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:reply-to:to:cc:references:in-reply-to
 :subject:date:message-id:mime-version:content-transfer-encoding
 :content-language:thread-index;
 bh=F5tUFeKbpaEUrhow1U7w2I/lFPTZrbFATqkKv3cbFJA=;
 b=JLRE6qahk9QmVoRg4pysLzFMp1HhRWx9wgRurscD+oTtnc7L/DRDXnld+dyd403cD1
 qr4Pu30f1x1tprw28etHZtZlTEBPvYnZFF1upsFhirukE9g6b3gvUhutHgyQe51LyLwH
 PAKQ2n1f37IhIlNEoVb8ArRDmHkIdHQSJf1HZhTkkD11Ao7fllTTMDJM0A/2xIqjq3Ps
 nZmFxyUCByUSV+4SfXx5TLIQSAJD6vHqzzn1p4XRjAE0bggb4OXAUEnXNzsuZ3fcsTsY
 cjHpFaGpehlg2J+J9TQtLM9WtLcDs0z5St7bsTmhAiBPIOyWPMnJ5g+aN9K6sxbKPG+B
 /21Q==
X-Gm-Message-State: AOAM5315eRqHJAelyAIYZL13EOQDJZfPQiopQ1sGqq8MDZvxeNLXldzN
 YwdpRfMkWMlcjdZ9eI9joyw=
X-Google-Smtp-Source: ABdhPJxkLn4nLGdKW7V2mqOMQI69SYGDw7w/jcuyd53OGVblkZrELtEp9tgShRP5K992kz6iGt4boQ==
X-Received: by 2002:a1c:6a11:: with SMTP id f17mr8064960wmc.143.1600329477743; 
 Thu, 17 Sep 2020 00:57:57 -0700 (PDT)
Received: from CBGR90WXYV0 (host86-176-94-160.range86-176.btcentralplus.com.
 [86.176.94.160])
 by smtp.gmail.com with ESMTPSA id c25sm9433892wml.31.2020.09.17.00.57.54
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Thu, 17 Sep 2020 00:57:57 -0700 (PDT)
From: Paul Durrant <xadimgnik@gmail.com>
X-Google-Original-From: "Paul Durrant" <paul@xen.org>
To: "'Eduardo Habkost'" <ehabkost@redhat.com>,
	<qemu-devel@nongnu.org>
References: <20200916182519.415636-1-ehabkost@redhat.com>
 <20200916182519.415636-6-ehabkost@redhat.com>
In-Reply-To: <20200916182519.415636-6-ehabkost@redhat.com>
Subject: RE: [PATCH 5/5] [automated] Use OBJECT_DECLARE_SIMPLE_TYPE when
 possible
Date: Thu, 17 Sep 2020 08:57:54 +0100
Message-ID: <007d01d68cc8$4146b8b0$c3d42a10$@xen.org>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Mailer: Microsoft Outlook 16.0
Content-Language: en-gb
Thread-Index: AQIelPz0+HUIa2jn7mxP/pozU40YBAFKLlCOqNIUBNA=
Received-SPF: pass client-ip=2a00:1450:4864:20::341;
 envelope-from=xadimgnik@gmail.com; helo=mail-wm1-x341.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.23
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Reply-To: paul@xen.org
Cc: 'Corey Minyard' <cminyard@mvista.com>, 'Jan Kiszka' <jan.kiszka@web.de>,
 'KONRAD Frederic' <frederic.konrad@adacore.com>,
 'Alberto Garcia' <berto@igalia.com>, 'Paul Burton' <paulburton@kernel.org>,
 'Halil Pasic' <pasic@linux.ibm.com>,
 =?utf-8?Q?'Herv=C3=A9_Poussineau'?= <hpoussin@reactos.org>,
 'Anthony Perard' <anthony.perard@citrix.com>,
 'Samuel Thibault' <samuel.thibault@ens-lyon.org>, qemu-block@nongnu.org,
 'Laurent Vivier' <lvivier@redhat.com>,
 "'Dr. David Alan Gilbert'" <dgilbert@redhat.com>,
 'Beniamino Galvani' <b.galvani@gmail.com>,
 'Eric Auger' <eric.auger@redhat.com>,
 'Alex Williamson' <alex.williamson@redhat.com>, 'Peter Xu' <peterx@redhat.com>,
 'Stefan Hajnoczi' <stefanha@redhat.com>, 'John Snow' <jsnow@redhat.com>,
 'Richard Henderson' <rth@twiddle.net>, 'Kevin Wolf' <kwolf@redhat.com>,
 'Andrew Jeffery' <andrew@aj.id.au>, 'Chris Wulff' <crwulff@gmail.com>,
 =?utf-8?Q?'Philippe_Mathieu-Daud=C3=A9'?= <f4bug@amsat.org>,
 'Subbaraya Sundeep' <sundeep.lkml@gmail.com>,
 'Zhang Chen' <chen.zhang@intel.com>, 'Michael Walle' <michael@walle.cc>,
 qemu-ppc@nongnu.org, 'Igor Mammedov' <imammedo@redhat.com>,
 'Fam Zheng' <fam@euphon.net>, 'Peter Maydell' <peter.maydell@linaro.org>,
 'Sarah Harris' <S.E.Harris@kent.ac.uk>, 'Anup Patel' <anup.patel@wdc.com>,
 'Matthew Rosato' <mjrosato@linux.ibm.com>,
 'David Hildenbrand' <david@redhat.com>, 'Max Filippov' <jcmvbkbc@gmail.com>,
 'Huacai Chen' <chenhc@lemote.com>,
 'Raphael Norwitz' <raphael.norwitz@nutanix.com>,
 'Stefano Stabellini' <sstabellini@kernel.org>,
 'Yoshinori Sato' <ysato@users.sourceforge.jp>,
 'Andrey Smirnov' <andrew.smirnov@gmail.com>, 'Helge Deller' <deller@gmx.de>,
 'Aleksandar Markovic' <aleksandar.qemu.devel@gmail.com>,
 "'Gonglei \(Arei\)'" <arei.gonglei@huawei.com>,
 'Artyom Tarasenko' <atar4qemu@gmail.com>, 'Eric Farman' <farman@linux.ibm.com>,
 'Amit Shah' <amit@kernel.org>, 'Greg Kurz' <groug@kaod.org>,
 'Niek Linnenbank' <nieklinnenbank@gmail.com>, qemu-arm@nongnu.org,
 'Michael Rolnik' <mrolnik@gmail.com>,
 =?utf-8?Q?'C=C3=A9dric_Le_Goater'?= <clg@kaod.org>, qemu-riscv@nongnu.org,
 'Ben Warren' <ben@skyportsystems.com>,
 'Igor Mitsyanko' <i.mitsyanko@gmail.com>,
 'Radoslaw Biernacki' <rad@semihalf.com>, qemu-s390x@nongnu.org,
 'Peter Chubb' <peter.chubb@nicta.com.au>,
 'Aurelien Jarno' <aurelien@aurel32.net>,
 'Sagar Karandikar' <sagark@eecs.berkeley.edu>,
 'Jason Wang' <jasowang@redhat.com>, 'Jiaxun Yang' <jiaxun.yang@flygoat.com>,
 'Gerd Hoffmann' <kraxel@redhat.com>,
 "'Edgar E. Iglesias'" <edgar.iglesias@gmail.com>,
 'Guan Xuetao' <gxt@mprc.pku.edu.cn>, 'Rob Herring' <robh@kernel.org>,
 kvm@vger.kernel.org, 'Juan Quintela' <quintela@redhat.com>,
 'Laszlo Ersek' <lersek@redhat.com>,
 'Christian Borntraeger' <borntraeger@de.ibm.com>,
 'Joel Stanley' <joel@jms.id.au>, 'Leif Lindholm' <leif@nuviainc.com>,
 'Antony Pavlov' <antonynpavlov@gmail.com>,
 'Aleksandar Rikalo' <aleksandar.rikalo@syrmia.com>,
 'Mark Cave-Ayland' <mark.cave-ayland@ilande.co.uk>,
 'Fabien Chouteau' <chouteau@adacore.com>, xen-devel@lists.xenproject.org,
 'Bastian Koppelmann' <kbastian@mail.uni-paderborn.de>,
 'Andrew Baumann' <Andrew.Baumann@microsoft.com>,
 'Max Reitz' <mreitz@redhat.com>, 'Dmitry Fleytman' <dmitry.fleytman@gmail.com>,
 'Li Zhijian' <lizhijian@cn.fujitsu.com>,
 "'Michael S. Tsirkin'" <mst@redhat.com>,
 'Christian Schoenebeck' <qemu_oss@crudebyte.com>,
 'Sven Schnelle' <svens@stackframe.org>, 'Marek Vasut' <marex@denx.de>,
 =?utf-8?Q?'Marc-Andr=C3=A9_Lureau'?= <marcandre.lureau@redhat.com>,
 'Alistair Francis' <alistair@alistair23.me>,
 'Pavel Dovgalyuk' <pavel.dovgaluk@ispras.ru>,
 'David Gibson' <david@gibson.dropbear.id.au>,
 'Tony Krowiak' <akrowiak@linux.ibm.com>,
 "'Daniel P. Berrange'" <berrange@redhat.com>,
 'Pierre Morel' <pmorel@linux.ibm.com>, 'Thomas Huth' <huth@tuxfamily.org>,
 'Jean-Christophe Dubois' <jcd@tribudubois.net>,
 'Palmer Dabbelt' <palmer@dabbelt.com>, 'Cornelia Huck' <cohuck@redhat.com>,
 'Paolo Bonzini' <pbonzini@redhat.com>, 'Stefan Berger' <stefanb@linux.ibm.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

> -----Original Message-----
> From: Eduardo Habkost <ehabkost@redhat.com>
> Sent: 16 September 2020 19:25
> To: qemu-devel@nongnu.org
> Cc: Paolo Bonzini <pbonzini@redhat.com>; Daniel P. Berrange =
<berrange@redhat.com>; Gonglei (Arei)
> <arei.gonglei@huawei.com>; Igor Mammedov <imammedo@redhat.com>; =
Laurent Vivier <lvivier@redhat.com>;
> Amit Shah <amit@kernel.org>; Stefan Berger <stefanb@linux.ibm.com>; =
Michael S. Tsirkin
> <mst@redhat.com>; Greg Kurz <groug@kaod.org>; Christian Schoenebeck =
<qemu_oss@crudebyte.com>; Marcel
> Apfelbaum <marcel.apfelbaum@gmail.com>; Aleksandar Markovic =
<aleksandar.qemu.devel@gmail.com>;
> Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>; Aurelien Jarno =
<aurelien@aurel32.net>; Richard Henderson
> <rth@twiddle.net>; Peter Maydell <peter.maydell@linaro.org>; Rob =
Herring <robh@kernel.org>; Joel
> Stanley <joel@jms.id.au>; Jan Kiszka <jan.kiszka@web.de>; Andrzej =
Zaborowski <balrogg@gmail.com>;
> Radoslaw Biernacki <rad@semihalf.com>; Leif Lindholm =
<leif@nuviainc.com>; Edgar E. Iglesias
> <edgar.iglesias@gmail.com>; Alistair Francis <alistair@alistair23.me>; =
Gerd Hoffmann
> <kraxel@redhat.com>; Michael Walle <michael@walle.cc>; John Snow =
<jsnow@redhat.com>; Kevin Wolf
> <kwolf@redhat.com>; Max Reitz <mreitz@redhat.com>; Marc-Andr=C3=A9 =
Lureau <marcandre.lureau@redhat.com>;
> Igor Mitsyanko <i.mitsyanko@gmail.com>; Fabien Chouteau =
<chouteau@adacore.com>; KONRAD Frederic
> <frederic.konrad@adacore.com>; Alberto Garcia <berto@igalia.com>; =
Thomas Huth <huth@tuxfamily.org>;
> David Gibson <david@gibson.dropbear.id.au>; Mark Cave-Ayland =
<mark.cave-ayland@ilande.co.uk>; Herv=C3=A9
> Poussineau <hpoussin@reactos.org>; Aleksandar Rikalo =
<aleksandar.rikalo@syrmia.com>; BALATON Zoltan
> <balaton@eik.bme.hu>; Guan Xuetao <gxt@mprc.pku.edu.cn>; Helge Deller =
<deller@gmx.de>; Corey Minyard
> <cminyard@mvista.com>; Stefano Stabellini <sstabellini@kernel.org>; =
Anthony Perard
> <anthony.perard@citrix.com>; Paul Durrant <paul@xen.org>; Chris Wulff =
<crwulff@gmail.com>; Marek Vasut
> <marex@denx.de>; Huacai Chen <chenhc@lemote.com>; Jiaxun Yang =
<jiaxun.yang@flygoat.com>; Artyom
> Tarasenko <atar4qemu@gmail.com>; Jason Wang <jasowang@redhat.com>; =
Dmitry Fleytman
> <dmitry.fleytman@gmail.com>; Max Filippov <jcmvbkbc@gmail.com>; Sven =
Schnelle <svens@stackframe.org>;
> Christian Borntraeger <borntraeger@de.ibm.com>; Cornelia Huck =
<cohuck@redhat.com>; Halil Pasic
> <pasic@linux.ibm.com>; David Hildenbrand <david@redhat.com>; Matthew =
Rosato <mjrosato@linux.ibm.com>;
> Fam Zheng <fam@euphon.net>; Yoshinori Sato =
<ysato@users.sourceforge.jp>; Samuel Thibault
> <samuel.thibault@ens-lyon.org>; Tony Krowiak <akrowiak@linux.ibm.com>; =
Pierre Morel
> <pmorel@linux.ibm.com>; Alex Williamson <alex.williamson@redhat.com>; =
Ben Warren
> <ben@skyportsystems.com>; Beniamino Galvani <b.galvani@gmail.com>; =
Niek Linnenbank
> <nieklinnenbank@gmail.com>; Andrew Baumann =
<Andrew.Baumann@microsoft.com>; Antony Pavlov
> <antonynpavlov@gmail.com>; Jean-Christophe Dubois =
<jcd@tribudubois.net>; Peter Chubb
> <peter.chubb@nicta.com.au>; Andrey Smirnov <andrew.smirnov@gmail.com>; =
Subbaraya Sundeep
> <sundeep.lkml@gmail.com>; Michael Rolnik <mrolnik@gmail.com>; Sarah =
Harris <S.E.Harris@kent.ac.uk>;
> Peter Xu <peterx@redhat.com>; C=C3=A9dric Le Goater <clg@kaod.org>; =
Andrew Jeffery <andrew@aj.id.au>;
> Laszlo Ersek <lersek@redhat.com>; Paul Burton <paulburton@kernel.org>; =
Palmer Dabbelt
> <palmer@dabbelt.com>; Sagar Karandikar <sagark@eecs.berkeley.edu>; =
Bastian Koppelmann
> <kbastian@mail.uni-paderborn.de>; Anup Patel <anup.patel@wdc.com>; =
Eric Farman <farman@linux.ibm.com>;
> Raphael Norwitz <raphael.norwitz@nutanix.com>; Dr. David Alan Gilbert =
<dgilbert@redhat.com>; Stefan
> Hajnoczi <stefanha@redhat.com>; Eric Auger <eric.auger@redhat.com>; =
Juan Quintela
> <quintela@redhat.com>; Pavel Dovgalyuk <pavel.dovgaluk@ispras.ru>; =
Zhang Chen <chen.zhang@intel.com>;
> Li Zhijian <lizhijian@cn.fujitsu.com>; qemu-arm@nongnu.org; =
qemu-block@nongnu.org; qemu-
> ppc@nongnu.org; kvm@vger.kernel.org; xen-devel@lists.xenproject.org; =
qemu-s390x@nongnu.org; qemu-
> riscv@nongnu.org
> Subject: [PATCH 5/5] [automated] Use OBJECT_DECLARE_SIMPLE_TYPE when =
possible
>=20
> This converts existing DECLARE_INSTANCE_CHECKER usage to
> OBJECT_DECLARE_SIMPLE_TYPE when possible.
>=20
> $ ./scripts/codeconverter/converter.py -i \
>   --pattern=3DAddObjectDeclareSimpleType $(git grep -l '' -- '*.[ch]')
>=20
> Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>

Acked-by: Paul Durrant <paul@xen.org>


