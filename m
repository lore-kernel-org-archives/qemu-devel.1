Return-Path: <SRS0=hQJD=5C=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1FC27C1975A
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Mar 2020 17:28:03 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E240520663
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Mar 2020 17:28:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="V/TfXHUo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E240520663
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37506 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jEG0Y-0002bk-1T
	for qemu-devel@archiver.kernel.org; Tue, 17 Mar 2020 13:28:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35729)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <jwsu1986@gmail.com>) id 1jEFzn-00028v-TM
 for qemu-devel@nongnu.org; Tue, 17 Mar 2020 13:27:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <jwsu1986@gmail.com>) id 1jEFzm-00070y-1o
 for qemu-devel@nongnu.org; Tue, 17 Mar 2020 13:27:15 -0400
Received: from mail-ot1-x335.google.com ([2607:f8b0:4864:20::335]:45133)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <jwsu1986@gmail.com>) id 1jEFzl-0006vk-Rf
 for qemu-devel@nongnu.org; Tue, 17 Mar 2020 13:27:13 -0400
Received: by mail-ot1-x335.google.com with SMTP id e9so15291797otr.12
 for <qemu-devel@nongnu.org>; Tue, 17 Mar 2020 10:27:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :content-transfer-encoding;
 bh=qyEwlJMeh5FdV5NrRmJi69dROtlF7hyB6qqsXgOqPD0=;
 b=V/TfXHUoA4zVGl3KO9XR1X22JIezEWBG7w5I5i9vxbFMRHzrdcpcQccZHaFsWGYpZH
 yaWdqKQ1pONZeJZl+a+Sd7fSDl03aNuZzu0M7PiFJyCPZfOij4hJ0tLiPNtjdUZnB4vW
 SdqcIgl5yoiu0V5F+VTI8WS04WGvcjUvUpjUJe3/XpVXE2i0bgoIsfmq8R/pcQVeFVFp
 ZQ7YNbWnIsT1gCDjG/A0PBfC7Cb8JXKcdRYR9WRGFvWwxbtZsshN8Qz8hIH8z/bEZBWh
 lG9fSNwW8fVsUvBStp7PBZTr6IGNCgwFd6Txlgync/KCRrKTJELZUczUx6PWA8VLUH+G
 iWZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:content-transfer-encoding;
 bh=qyEwlJMeh5FdV5NrRmJi69dROtlF7hyB6qqsXgOqPD0=;
 b=K5cdKG6veM8rMRFpzgpbhhbcWu/wM6k/d9ADPtPGtPjl62r/spjjG2GrBz7+S9wF3d
 tlfa9kYa6EL2bMxkOmuEEJyjo4q/mwDsmA83W7BQ4ewTNb1dICGNxV15BZuVzdotggYu
 SiiBFVzZBiy71jVsKHjQWSNkeZROasFngNvkx4skyR96TviNRSlmidXZp2nWafys7jMd
 PkJOHrvoV/vwr3qzo+LD9dCmf7Z5tl+1iAmOGOqcNWFmAbitsDW+NeNi7Ua+uu+WgRbQ
 F+lBTSeblSWnnxbwJ1+l/f4OUPgymYv1U16366WWT6cx32AY++u8pfJ06XhFCg+0LW+U
 6wQg==
X-Gm-Message-State: ANhLgQ2Br4b53w0chvelpeH7IhFQj2pLx68ZVgsaof6HZW/tJV9Nja1N
 vcL5wJWDrNWfUNJpmZX9fN6rJMw2XelbOiH8PE3wQs57qsw=
X-Google-Smtp-Source: ADFU+vvKJXy5BbeWdbSrrhBSAw27jTGuSkQS7oX1hxkW2CDxgIwzpwr19UJUsqgsLypV5hHJ1ThZ/OcQAUQedFzSVjg=
X-Received: by 2002:a9d:12a3:: with SMTP id g32mr261340otg.111.1584466032329; 
 Tue, 17 Mar 2020 10:27:12 -0700 (PDT)
MIME-Version: 1.0
References: <CAFKS8hXFwmcoeUHfn48N8FZ7Q-BN4zW8pHU2o-N6u4_UX=iYkg@mail.gmail.com>
In-Reply-To: <CAFKS8hXFwmcoeUHfn48N8FZ7Q-BN4zW8pHU2o-N6u4_UX=iYkg@mail.gmail.com>
From: Jing-Wei Su <jwsu1986@gmail.com>
Date: Wed, 18 Mar 2020 01:27:01 +0800
Message-ID: <CAFKS8hUKUnOsyP5N6pb4NvJ-FPspXZzcp0cyKLNiQHhW_kYg2w@mail.gmail.com>
Subject: Re: "guest-reset" and "invalid runstate transition" in COLO SVM
To: qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::335
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hello,

I'm not sure whether the commit
(https://github.com/qemu/qemu/commit/f51d0b4178738bba87d796eba7444f6cdb3aa0=
fd)
can patch
to qemu-4.1.0 or qemu-4.2.0 directly.
After going through the COLO flow, the commit seems an individual
patch and to resolve  double-allocate colo_cache issue, right?
Or, it depends on other commits?

In my experiment, qemu-4.1.0/4.2.0 with the patch has a high
probability of the crash of SVM.

Thanks.
Sincerely,
JW

Jing-Wei Su <jwsu1986@gmail.com> =E6=96=BC 2020=E5=B9=B43=E6=9C=8817=E6=97=
=A5 =E9=80=B1=E4=BA=8C =E4=B8=8B=E5=8D=885:19=E5=AF=AB=E9=81=93=EF=BC=9A
>
> Hello,
>
> I'm testing  COLO in qemu-4.2.0 with the commit
> https://github.com/qemu/qemu/commit/f51d0b4178738bba87d796eba7444f6cdb3aa=
0fd.
>
> The qmp of SVM sometimes show the following errors ("guest-reset"
> or/and "invalid runstate transition") .
> Does any have idea about this?
>
> {"timestamp": {"seconds": 1584435907, "microseconds": 610964},
> "event": "RESUME"}
> {"timestamp": {"seconds": 1584435927, "microseconds": 553683}, "event": "=
STOP"}
> {"timestamp": {"seconds": 1584435980, "microseconds": 533344},
> "event": "RESUME"}
> {"timestamp": {"seconds": 1584435980, "microseconds": 579256},
> "event": "RESET", "data": {"guest": true, "reason": "guest-reset"}}
> {"timestamp": {"seconds": 1584435980, "microseconds": 588350}, "event": "=
STOP"}
> {"timestamp": {"seconds": 1584435980, "microseconds": 801483},
> "event": "RESUME"}
> {"timestamp": {"seconds": 1584435980, "microseconds": 802061}, "event": "=
STOP"}
> {"timestamp": {"seconds": 1584435980, "microseconds": 803988},
> "event": "RESET", "data": {"guest": true, "reason": "guest-reset"}}
> qemu-system-x86_64: invalid runstate transition: 'colo' -> 'prelaunch'
> secondary-nonshared.sh: line 25: 23457 Aborted                 (core
> dumped) qemu-system-x86_64 -name secondary -enable-kvm -cpu
> qemu64,+kvmclock -m 2048 -global kvm-apic.vapic=3Dfalse -netdev
> tap,id=3Dhn0,vhost=3Doff,helper=3D/usr/local/libexec/qemu-bridge-helper
> -device e1000,id=3De0,netdev=3Dhn0 -chardev
> socket,id=3Dred0,host=3D$primary_ip,port=3D9003,reconnect=3D1 -chardev
> socket,id=3Dred1,host=3D$primary_ip,port=3D9004,reconnect=3D1 -object
> filter-redirector,id=3Df1,netdev=3Dhn0,queue=3Dtx,indev=3Dred0 -object
> filter-redirector,id=3Df2,netdev=3Dhn0,queue=3Drx,outdev=3Dred1 -object
> filter-rewriter,id=3Drew0,netdev=3Dhn0,queue=3Dall -drive
> if=3Dnone,id=3Dparent0,file.filename=3D$imagefolder/secondary.qcow2,drive=
r=3Dqcow2
> -drive if=3Dnone,id=3Dchilds0,driver=3Dreplication,mode=3Dsecondary,file.=
driver=3Dqcow2,top-id=3Dcolo-disk0,file.file.filename=3D$imagefolder/second=
ary-active.qcow2,file.backing.driver=3Dqcow2,file.backing.file.filename=3D$=
imagefolder/secondary-hidden.qcow2,file.backing.backing=3Dparent0
> -drive if=3Dide,id=3Dcolo-disk0,driver=3Dquorum,read-pattern=3Dfifo,vote-=
threshold=3D1,children.0=3Dchilds0
> -qmp unix:/tmp/qmp-svm-sock,server,nowait -qmp stdio -vnc :5 -incoming
> tcp:0.0.0.0:9998
>
> My PVM and SVM are on the same PC.
> Here are the steps to setup my testing
> (1) Start PVM
> qemu-system-x86_64 -name primary -enable-kvm -cpu qemu64,+kvmclock -m
> 2048 -global kvm-apic.vapic=3Dfalse \
> -netdev tap,id=3Dhn0,vhost=3Doff,helper=3D/usr/local/libexec/qemu-bridge-=
helper \
> -device e1000,id=3De0,netdev=3Dhn0 \
> -drive if=3Dide,id=3Dcolo-disk0,driver=3Dquorum,read-pattern=3Dfifo,vote-=
threshold=3D1,children.0.file.filename=3D$imagefolder/primary.qcow2,childre=
n.0.driver=3Dqcow2
> \
> -qmp stdio -vnc :4
>
> (2) Add chardevs to PVM via qmp
> {'execute': 'qmp_capabilities'}
> {'execute': 'chardev-add', 'arguments':{ 'id': 'mirror0', 'backend':
> {'type': 'socket', 'data': {'addr': { 'type': 'inet', 'data': {
> 'host': '0.0.0.0', 'port': '9003' } }, 'server': true } } } }
> {'execute': 'chardev-add', 'arguments':{ 'id': 'compare1', 'backend':
> {'type': 'socket', 'data': {'addr': { 'type': 'inet', 'data': {
> 'host': '0.0.0.0', 'port': '9004' } }, 'server': true } } } }
> {'execute': 'chardev-add', 'arguments':{ 'id': 'compare0', 'backend':
> {'type': 'socket', 'data': {'addr': { 'type': 'inet', 'data': {
> 'host': '127.0.0.1', 'port': '9001' } }, 'server': true } } } }
> {'execute': 'chardev-add', 'arguments':{ 'id': 'compare0-0',
> 'backend': {'type': 'socket', 'data': {'addr': { 'type': 'inet',
> 'data': { 'host': '127.0.0.1', 'port': '9001' } }, 'server': false } }
> } }
> {'execute': 'chardev-add', 'arguments':{ 'id': 'compare_out',
> 'backend': {'type': 'socket', 'data': {'addr': { 'type': 'inet',
> 'data': { 'host': '127.0.0.1', 'port': '9005' } }, 'server': true } }
> } }
> {'execute': 'chardev-add', 'arguments':{ 'id': 'compare_out0',
> 'backend': {'type': 'socket', 'data': {'addr': { 'type': 'inet',
> 'data': { 'host': '127.0.0.1', 'port': '9005' } }, 'server': false } }
> } }
>
> (3) Start SVM
> primary_ip=3D127.0.0.1
> qemu-system-x86_64 -name secondary -enable-kvm -cpu qemu64,+kvmclock
> -m 2048 -global kvm-apic.vapic=3Dfalse \
> -netdev tap,id=3Dhn0,vhost=3Doff,helper=3D/usr/local/libexec/qemu-bridge-=
helper \
> -device e1000,id=3De0,netdev=3Dhn0 \
> -chardev socket,id=3Dred0,host=3D$primary_ip,port=3D9003,reconnect=3D1 \
> -chardev socket,id=3Dred1,host=3D$primary_ip,port=3D9004,reconnect=3D1 \
> -object filter-redirector,id=3Df1,netdev=3Dhn0,queue=3Dtx,indev=3Dred0 \
> -object filter-redirector,id=3Df2,netdev=3Dhn0,queue=3Drx,outdev=3Dred1 \
> -object filter-rewriter,id=3Drew0,netdev=3Dhn0,queue=3Dall \
> -drive if=3Dnone,id=3Dparent0,file.filename=3D$imagefolder/secondary.qcow=
2,driver=3Dqcow2
> \
> -drive if=3Dnone,id=3Dchilds0,driver=3Dreplication,mode=3Dsecondary,file.=
driver=3Dqcow2,top-id=3Dcolo-disk0,file.file.filename=3D$imagefolder/second=
ary-active.qcow2,file.backing.driver=3Dqcow2,file.backing.file.filename=3D$=
imagefolder/secondary-hidden.qcow2,file.backing.backing=3Dparent0
> \
> -drive if=3Dide,id=3Dcolo-disk0,driver=3Dquorum,read-pattern=3Dfifo,vote-=
threshold=3D1,children.0=3Dchilds0
> \
> -qmp stdio -vnc :5 -incoming tcp:0.0.0.0:9998
>
> (4) Start NBD server of SVM
> {'execute':'qmp_capabilities'}
> {'execute': 'nbd-server-start', 'arguments': {'addr': {'type': 'inet',
> 'data': {'host': '0.0.0.0', 'port': '9999'} } } }
> {'execute': 'nbd-server-add', 'arguments': {'device': 'parent0',
> 'writable': true } }
>
> (5) Invoke drive-mirror in PVM side
> {'execute': 'drive-mirror', 'arguments':{ 'device': 'colo-disk0',
> 'job-id': 'resync', 'target': 'nbd://127.0.0.2:9999/parent0', 'mode':
> 'existing', 'format': 'raw', 'sync': 'full'} }
>
> Wait until disk is synced, then:
> {'execute': 'stop'}
> {'execute': 'block-job-cancel', 'arguments':{ 'device': 'resync'} }
>
> (6) Add Filters and Start COLO Migrate
> {'execute': 'human-monitor-command', 'arguments':{ 'command-line':
> 'drive_add -n buddy
> driver=3Dreplication,mode=3Dprimary,file.driver=3Dnbd,file.host=3D127.0.0=
.1,file.port=3D9999,file.export=3Dparent0,node-name=3Dreplication0'}}
> {'execute': 'x-blockdev-change', 'arguments':{ 'parent': 'colo-disk0',
> 'node': 'replication0' } }
> {'execute': 'object-add', 'arguments':{ 'qom-type': 'filter-mirror',
> 'id': 'm0', 'props': { 'netdev': 'hn0', 'queue': 'tx', 'outdev':
> 'mirror0' } } }
> {'execute': 'object-add', 'arguments':{ 'qom-type':
> 'filter-redirector', 'id': 'redire0', 'props': { 'netdev': 'hn0',
> 'queue': 'rx', 'indev': 'compare_out' } } }
> {'execute': 'object-add', 'arguments':{ 'qom-type':
> 'filter-redirector', 'id': 'redire1', 'props': { 'netdev': 'hn0',
> 'queue': 'rx', 'outdev': 'compare0' } } }
> {'execute': 'object-add', 'arguments':{ 'qom-type': 'iothread', 'id':
> 'iothread1' } }
> {'execute': 'object-add', 'arguments':{ 'qom-type': 'colo-compare',
> 'id': 'comp0', 'props': { 'primary_in': 'compare0-0', 'secondary_in':
> 'compare1', 'outdev': 'compare_out0', 'iothread': 'iothread1' } } }
> {'execute': 'migrate-set-capabilities', 'arguments':{ 'capabilities':
> [ {'capability': 'x-colo', 'state': true } ] } }
> {'execute': 'migrate', 'arguments':{ 'uri': 'tcp:127.0.0.1:9998' } }
>
> Thanks!
> Sincerely,
> Jing-Wei

