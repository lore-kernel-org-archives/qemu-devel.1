Return-Path: <SRS0=EqPw=EE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D9F2C4363A
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Oct 2020 16:06:07 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8D5122076D
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Oct 2020 16:06:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="a8/JhIvh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8D5122076D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51812 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kYARB-0007kM-5d
	for qemu-devel@archiver.kernel.org; Thu, 29 Oct 2020 12:06:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47986)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1kYAOD-0004Y2-68
 for qemu-devel@nongnu.org; Thu, 29 Oct 2020 12:03:01 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:26772)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1kYAO7-0002AI-05
 for qemu-devel@nongnu.org; Thu, 29 Oct 2020 12:02:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1603987372;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=QVwPtG17bsi/VDuW860bQ9myZS8M0qBLL5tUUUYtsDw=;
 b=a8/JhIvhH+T1GSVnIlESa/tG30DDcZV4mDH8g3JzL+xuC4lkvLGGe8MVT1bFRl1FSxhcCA
 UMOy2YI39p/WpnVdf6luKCeRYy7qRRyq50LOKkDfQa4s42DJ2kvmpCmSjOKjsh4+AaKK57
 JQsPInqXPhtFKw0tPsFo5JaJ6OwJKxo=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-200-Cof88PM2O8WlU6dOj0Rupw-1; Thu, 29 Oct 2020 12:02:50 -0400
X-MC-Unique: Cof88PM2O8WlU6dOj0Rupw-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 46E9057209;
 Thu, 29 Oct 2020 16:02:43 +0000 (UTC)
Received: from [10.10.118.238] (ovpn-118-238.rdu2.redhat.com [10.10.118.238])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 895535D98C;
 Thu, 29 Oct 2020 16:01:28 +0000 (UTC)
To: QEMU Developers <qemu-devel@nongnu.org>
From: John Snow <jsnow@redhat.com>
Subject: Migrating to the gitlab issue tracker
Message-ID: <bda4f471-8ed6-3832-29ac-279a6d3bb7cc@redhat.com>
Date: Thu, 29 Oct 2020 12:01:27 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.3.1
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=jsnow@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=63.128.21.124; envelope-from=jsnow@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/29 01:47:28
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: Corey Minyard <cminyard@mvista.com>, Stefan Hajnoczi <stefanha@redhat.com>,
 Jeff Cody <codyprime@gmail.com>, Yuval Shaia <yuval.shaia.ml@gmail.com>,
 Markus Armbruster <armbru@redhat.com>,
 KONRAD Frederic <frederic.konrad@adacore.com>,
 Klaus Jensen <its@irrelevant.dk>, Alberto Garcia <berto@igalia.com>,
 zhanghailiang <zhang.zhanghailiang@huawei.com>,
 Ben Warren <ben@skyportsystems.com>,
 =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 Halil Pasic <pasic@linux.ibm.com>, Kamil Rytarowski <kamil@netbsd.org>,
 =?UTF-8?Q?Herv=c3=a9_Poussineau?= <hpoussin@reactos.org>,
 Anthony Perard <anthony.perard@citrix.com>,
 Samuel Thibault <samuel.thibault@ens-lyon.org>,
 Laszlo Ersek <lersek@redhat.com>, Jason Wang <jasowang@redhat.com>,
 Brad Smith <brad@comstyle.com>, Laurent Vivier <lvivier@redhat.com>,
 Jiri Pirko <jiri@resnulli.us>, Eduardo Habkost <ehabkost@redhat.com>,
 Xie Changlong <xiechanglong.d@gmail.com>, Riku Voipio <riku.voipio@iki.fi>,
 Peter Lieven <pl@kamp.de>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
 Beniamino Galvani <b.galvani@gmail.com>, Alexander Bulekov <alxndr@bu.edu>,
 Alex Williamson <alex.williamson@redhat.com>,
 Ronnie Sahlberg <ronniesahlberg@gmail.com>, John Snow <jsnow@redhat.com>,
 Aarushi Mehta <mehta.aaru20@gmail.com>, Richard Henderson <rth@twiddle.net>,
 Kevin Wolf <kwolf@redhat.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 Ed Maste <emaste@freebsd.org>, Chris Wulff <crwulff@gmail.com>,
 Laurent Vivier <laurent@vivier.eu>, Coiby Xu <Coiby.Xu@gmail.com>,
 Subbaraya Sundeep <sundeep.lkml@gmail.com>,
 Stefan Berger <stefanb@linux.ibm.com>,
 Bastian Koppelmann <kbastian@mail.uni-paderborn.de>,
 Igor Mammedov <imammedo@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>,
 Fam Zheng <fam@euphon.net>, Peter Maydell <peter.maydell@linaro.org>,
 Anup Patel <anup.patel@wdc.com>, Matthew Rosato <mjrosato@linux.ibm.com>,
 David Hildenbrand <david@redhat.com>, Michael Tokarev <mjt@tls.msk.ru>,
 Thomas Huth <thuth@redhat.com>, Max Filippov <jcmvbkbc@gmail.com>,
 Su Hang <suhang16@mails.ucas.ac.cn>,
 Alistair Francis <Alistair.Francis@wdc.com>, "Denis V. Lunev" <den@openvz.org>,
 Raphael Norwitz <raphael.norwitz@nutanix.com>, Hannes Reinecke <hare@suse.com>,
 Stefano Stabellini <sstabellini@kernel.org>,
 Yoshinori Sato <ysato@users.sourceforge.jp>, Zhang Chen <chen.zhang@intel.com>,
 Gonglei <arei.gonglei@huawei.com>, Radoslaw Biernacki <rad@semihalf.com>,
 Liu Yuan <namei.unix@gmail.com>, Artyom Tarasenko <atar4qemu@gmail.com>,
 Eric Farman <farman@linux.ibm.com>, Corey Minyard <minyard@acm.org>,
 Stefan Weil <sw@weilnetz.de>, Julia Suvorova <jusual@redhat.com>,
 Greg Kurz <groug@kaod.org>, Cameron Esfahani <dirty@apple.com>,
 Niek Linnenbank <nieklinnenbank@gmail.com>, Jan Kiszka <jan.kiszka@web.de>,
 =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>,
 Stafford Horne <shorne@gmail.com>, Paul Burton <paulburton@kernel.org>,
 Igor Mitsyanko <i.mitsyanko@gmail.com>, Cornelia Huck <cohuck@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
 Tyrone Ting <kfting@nuvoton.com>, Wenchao Wang <wenchao.wang@intel.com>,
 Michael Rolnik <mrolnik@gmail.com>, Aurelien Jarno <aurelien@aurel32.net>,
 Sagar Karandikar <sagark@eecs.berkeley.edu>, Paul Durrant <paul@xen.org>,
 Anthony Green <green@moxielogic.com>, Bin Meng <bin.meng@windriver.com>,
 Peter Xu <peterx@redhat.com>, Colin Xu <colin.xu@intel.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Guan Xuetao <gxt@mprc.pku.edu.cn>, Ari Sundholm <ari@tuxera.com>,
 Rob Herring <robh@kernel.org>, Juan Quintela <quintela@redhat.com>,
 Michael Roth <mdroth@linux.vnet.ibm.com>,
 Christian Borntraeger <borntraeger@de.ibm.com>,
 Antony Pavlov <antonynpavlov@gmail.com>, Jason Dillaman <dillaman@redhat.com>,
 Joel Stanley <joel@jms.id.au>, Sergio Lopez <slp@redhat.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Fabien Chouteau <chouteau@adacore.com>,
 Roman Bolshakov <r.bolshakov@yadro.com>, Cleber Rosa <crosa@redhat.com>,
 Keith Busch <kbusch@kernel.org>, Sunil Muthuswamy <sunilmut@microsoft.com>,
 Eduardo Otubo <otubo@redhat.com>,
 Viktor Prutyanov <viktor.prutyanov@phystech.edu>,
 "Richard W.M. Jones" <rjones@redhat.com>, Max Reitz <mreitz@redhat.com>,
 Pavel Pisa <pisa@cmp.felk.cvut.cz>,
 Dmitry Fleytman <dmitry.fleytman@gmail.com>,
 Li Zhijian <lizhijian@cn.fujitsu.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Christian Schoenebeck <qemu_oss@crudebyte.com>,
 Vincenzo Maffione <v.maffione@gmail.com>, Huacai Chen <chenhc@lemote.com>,
 Jiri Slaby <jslaby@suse.cz>, Peter Chubb <peter.chubb@nicta.com.au>,
 Marek Vasut <marex@denx.de>, Jia Liu <proljc@gmail.com>,
 Sven Schnelle <svens@stackframe.org>,
 Havard Skinnemoen <hskinnemoen@google.com>,
 =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>,
 Alistair Francis <alistair@alistair23.me>,
 Richard Henderson <richard.henderson@linaro.org>,
 Vikram Garhwal <fnu.vikram@xilinx.com>,
 Pavel Dovgalyuk <pavel.dovgaluk@ispras.ru>,
 Giuseppe Lettieri <g.lettieri@iet.unipi.it>, Luigi Rizzo <rizzo@iet.unipi.it>,
 Li-Wen Hsu <lwhsu@freebsd.org>, David Gibson <david@gibson.dropbear.id.au>,
 Tony Krowiak <akrowiak@linux.ibm.com>,
 "Daniel P. Berrange" <berrange@redhat.com>,
 Xiao Guangrong <xiaoguangrong.eric@gmail.com>,
 Pierre Morel <pmorel@linux.ibm.com>, Eric Auger <eric.auger@redhat.com>,
 Thomas Huth <huth@tuxfamily.org>, Wen Congyang <wencongyang2@huawei.com>,
 Marcelo Tosatti <mtosatti@redhat.com>, Shannon Zhao <shannon.zhaosl@gmail.com>,
 Palmer Dabbelt <palmer@dabbelt.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Bin Meng <bmeng.cn@gmail.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

If you're in the CC list, it's because you are listed in MAINTAINERS.

Paolo's QEMU keynote this morning mentioned the possible use of the 
Gitlab issue tracker instead of using Launchpad.

I'm quite fond of the gitlab issue tracker, I think it works quite well 
and it has pretty good and uncomplicated API access to it in order to 
customize your workflow if you'd really like to.

In experimenting with my mirror on gitlab though, I was unable to find a 
way to configure it to send issue tracker notifications to the email 
list. A move to gitlab would likely mean, then:

1. The cessation of (automatic) issue tracker mails to the list
2. The loss of the ability to update the issue tracker by replying to 
said emails
3. Anyone listed in MAINTAINERS would be expected to have a gitlab 
account in order to interact with the issue tracker.

However, once you have a gitlab account, you DO gain the ability to 
receive emails for issues; possibly only those tagged with labels that 
you cared about -- giving a nice filtering mechanism to receive only 
bugs you care about.

Gitlab also does support individual accounts updating issues using a 
generated personalized email address, so if the email workflow is 
crucial to you, it is still available.

I'm for it, or at least for beginning a pilot program where we 
experiment with the idea for interested parties. I wanted to send up a 
trial balloon to see how we were feeling about this.

--js


