Return-Path: <SRS0=Ouwy=U3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0518BC4321A
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Jun 2019 13:20:12 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C2C392083B
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Jun 2019 13:20:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=greensocs.com header.i=@greensocs.com header.b="J17v4Hfv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C2C392083B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=greensocs.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59766 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hgqnM-0004yv-VN
	for qemu-devel@archiver.kernel.org; Fri, 28 Jun 2019 09:20:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41483)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <damien.hedde@greensocs.com>) id 1hgqGN-0008Ov-5E
 for qemu-devel@nongnu.org; Fri, 28 Jun 2019 08:46:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <damien.hedde@greensocs.com>) id 1hgqGL-0001aJ-9d
 for qemu-devel@nongnu.org; Fri, 28 Jun 2019 08:45:59 -0400
Received: from beetle.greensocs.com ([5.135.226.135]:36912)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <damien.hedde@greensocs.com>)
 id 1hgqGK-0001Qj-LL
 for qemu-devel@nongnu.org; Fri, 28 Jun 2019 08:45:57 -0400
Received: from kouign-amann.bar.greensocs.com (unknown [172.16.11.117])
 by beetle.greensocs.com (Postfix) with ESMTPS id D110496F52;
 Fri, 28 Jun 2019 12:45:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=greensocs.com;
 s=mail; t=1561725938;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=5E+PVllopk2YYH5uus5dZpgYHFl1omwtkkP62F6e6xg=;
 b=J17v4HfvxT60Bo8S547B2gU12BrfwKQHon/Dc8OALcPEE47RHTzpPv0T6xiSYnFrgHARuM
 bSrBDdWWQ3QCVWoWZ6NgOHx+7xQ/khjRoplXUPoFf38hyJsn2XItkQdbSvxGZ6cyntKfRk
 UwIfeDhDshCkFcAIdIKJa8eLQAYS+Ks=
From: Damien Hedde <damien.hedde@greensocs.com>
To: qemu-devel@nongnu.org
Date: Fri, 28 Jun 2019 14:45:29 +0200
Message-Id: <20190628124534.10679-1-damien.hedde@greensocs.com>
X-Mailer: git-send-email 2.22.0
MIME-Version: 1.0
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=greensocs.com; 
 s=mail; t=1561725938;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=5E+PVllopk2YYH5uus5dZpgYHFl1omwtkkP62F6e6xg=;
 b=smy18a2cpSQy4z35cGgRxlb7xhQR0NOsWrUL9b81sqHf3kpw0XDKLrOP2H14QGpK+mZtR6
 tdi8vVO7yGFu0ZWLDujxXCEHesrXFYLl+JzDfdzMKRu2ILoEZowQwLkokUq+FwiU6juf4M
 /Lmr0lKzR4Epb4H5I9iFLN/dA1AXsVk=
ARC-Seal: i=1; s=mail; d=greensocs.com; t=1561725938; a=rsa-sha256; cv=none;
 b=hn1lURwkTQ4LN0ICUMFqYRqWJxNxWKbtUc40y+d7yQmhSJLZztPfQHa9Rdh/9R6KXLbf51
 zG4OmsgnQts9SQ+0nf7pSLdMHA716kepQM5nuFou3kglr7BSxO5xjS+dGez0zDRQJDjPj6
 Qo1DiVdx7kFuqo0HrLqkLl4CBbce5lQ=
ARC-Authentication-Results: i=1;
	beetle.greensocs.com;
	none
X-Spam: Yes
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 5.135.226.135
Subject: [Qemu-devel] [RFC PATCH 0/5] FAULT INJECTION FRAMEWORK
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
Cc: Damien Hedde <damien.hedde@greensocs.com>, ehabkost@redhat.com,
 mark.burton@greensocs.com, armbru@redhat.com, sakisp@xilinx.com,
 edgari@xilinx.com, crosa@redhat.com, pbonzini@redhat.com,
 luc.michel@greensocs.com, rth@twiddle.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi all,

This series adds a python framework aiming to provide some ways to do fau=
lt
injection in a running vm. In its current state, it allows to easily inte=
ract
with memory, change gpios and qom properties.

The framework consists in a python script based on the qmp existing modul=
e
which allows to interact with the vm.

The series introduces a QMP command to schedule some virtual-clock-time-b=
ased
notifications. The notification is sent back to the python framework and =
can
be used to build time-driven fault scenario.

Additionaly the series adds some new QMP commands:

Commands are added to read/write memory or memory-mapped registers. Argum=
ents
are similar to the existing [p]memsave commands.

A command is added to set a value to a qdev gpio.

Here's is a simple visual example which inject characters on the uart out=
put
of the zynq platform:
$ # qemu must have been launched with -qmp unix:/tmp/qmpsock,server
$ # create the python framework object
$ import fault_injection
$ inj =3D fault_injection.FaultInjectionFramework("/tmp/qmpsock", 0)
$
$ # function which display a 'X' to the first uart
$ # it access directly the register using the physical address
$ def cb():
$   inj.write_pmem(0xe0000030,4, 88)
$
$ # schedule the function on a notification in 10s
$ inj.notify(10 * 1000 * 1000 * 1000, cb, True)
$
$ # handle one notification
$ inj.run_once()

The framework has been tested using python 2, on qemu running xilinx_zynq=
 or
virt arm machines.

The series is organised as follows. Patches 1 and 2 adds the memory qmp a=
nd
gpio commands. Patch 3 adds the notification mechanism. Patches 4 and 5 a=
dd
a python helper module and some documention.

Thanks to the Xilinx's QEMU team who sponsored this work.

Damien Hedde (5):
  introduce [p]mem(read|write) qmp commands
  introduce a qmp command to set gpios
  add qmp time-notify event triggering system
  fault_injection: introduce Python scripting framework
  docs: add fault injection framework documentation

 cpus.c                         | 126 +++++++++++++++
 docs/fault_injection.txt       | 149 ++++++++++++++++++
 monitor/Makefile.objs          |   1 +
 monitor/qmp-cmd-time-notify.c  | 116 ++++++++++++++
 monitor/qmp-cmds.c             |  30 ++++
 monitor/trace-events           |   4 +
 qapi/misc.json                 | 196 +++++++++++++++++++++++
 scripts/qmp/fault_injection.py | 278 +++++++++++++++++++++++++++++++++
 8 files changed, 900 insertions(+)
 create mode 100644 docs/fault_injection.txt
 create mode 100644 monitor/qmp-cmd-time-notify.c
 create mode 100644 scripts/qmp/fault_injection.py

--=20
2.22.0


