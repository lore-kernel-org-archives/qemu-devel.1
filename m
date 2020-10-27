Return-Path: <SRS0=gwGE=EC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6EC5C388F9
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Oct 2020 13:46:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3D98421707
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Oct 2020 13:46:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="EqYC4Cmt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3D98421707
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49742 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kXPIx-0008JO-6u
	for qemu-devel@archiver.kernel.org; Tue, 27 Oct 2020 09:46:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57716)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ehabkost@redhat.com>)
 id 1kXP86-0002Xb-0U
 for qemu-devel@nongnu.org; Tue, 27 Oct 2020 09:35:15 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:49862)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <ehabkost@redhat.com>)
 id 1kXP83-0000vp-Qx
 for qemu-devel@nongnu.org; Tue, 27 Oct 2020 09:35:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1603805710;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=48DDjV0LflkNL633RquGk2YjdAQCaW2TJDSVm0mUjKc=;
 b=EqYC4CmtIwHiXj1qaXfA+C33iAZT2f78gLllV1Mjf7od6eN9exjydav8sGer7y2PObRWup
 nCr8LVJw/YIzuZQ4m7t8ipL/kOlQ3+gJQBFg19RHMHCIj15Uhu12s8TMU/+GXuH5qw0GZr
 mBC6fyyrwY1UjSSnSB8OPrzafBpPwvI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-421-65NN1LvUPCm12SiMlp0d5Q-1; Tue, 27 Oct 2020 09:35:09 -0400
X-MC-Unique: 65NN1LvUPCm12SiMlp0d5Q-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id B43211016CED;
 Tue, 27 Oct 2020 13:35:07 +0000 (UTC)
Received: from localhost (ovpn-114-68.rdu2.redhat.com [10.10.114.68])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 5CE616EF55;
 Tue, 27 Oct 2020 13:35:07 +0000 (UTC)
Date: Tue, 27 Oct 2020 09:35:06 -0400
From: Eduardo Habkost <ehabkost@redhat.com>
To: tobin@linux.ibm.com
Subject: Re: [PATCH v7] sev: add sev-inject-launch-secret
Message-ID: <20201027133506.GC5733@habkost.net>
References: <20201022053909.34123-1-tobin@linux.ibm.com>
MIME-Version: 1.0
In-Reply-To: <20201022053909.34123-1-tobin@linux.ibm.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=ehabkost@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=216.205.24.124; envelope-from=ehabkost@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/27 01:06:06
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
Cc: thomas.lendacky@amd.com, brijesh.singh@amd.com, jejb@linux.ibm.com,
 tobin@ibm.com, qemu-devel@nongnu.org, dgilbert@redhat.com, berrange@redhat.com,
 pbonzini@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, Oct 22, 2020 at 01:39:09AM -0400, tobin@linux.ibm.com wrote:
> From: Tobin Feldman-Fitzthum <tobin@linux.ibm.com>
>=20
> AMD SEV allows a guest owner to inject a secret blob
> into the memory of a virtual machine. The secret is
> encrypted with the SEV Transport Encryption Key and
> integrity is guaranteed with the Transport Integrity
> Key. Although QEMU facilitates the injection of the
> launch secret, it cannot access the secret.
>=20
> Signed-off-by: Tobin Feldman-Fitzthum <tobin@linux.ibm.com>
> Reviewed-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
> Reviewed-by: Brijesh Singh <brijesh.singh@amd.com>

I was going to queue it, but unfortunately it failed to build on some hosts=
:

https://gitlab.com/ehabkost/qemu/-/jobs/814250096

[1892/5203] Compiling C object libqemu-alpha-softmmu.fa.p/monitor_misc.c.o
FAILED: libqemu-alpha-softmmu.fa.p/monitor_misc.c.o=20
arm-linux-gnueabi-gcc -Ilibqemu-alpha-softmmu.fa.p -I. -I.. -Itarget/alpha =
-I../target/alpha -I../capstone/include/capstone -Iqapi -Itrace -Iui -Iui/s=
hader -I/usr/include/libdrm -I/usr/include/pixman-1 -I/usr/include/glib-2.0=
 -I/usr/lib/arm-linux-gnueabi/glib-2.0/include -fdiagnostics-color=3Dauto -=
pipe -Wall -Winvalid-pch -Werror -std=3Dgnu99 -O2 -g -U_FORTIFY_SOURCE -D_F=
ORTIFY_SOURCE=3D2 -D_GNU_SOURCE -D_FILE_OFFSET_BITS=3D64 -D_LARGEFILE_SOURC=
E -Wstrict-prototypes -Wredundant-decls -Wundef -Wwrite-strings -Wmissing-p=
rototypes -fno-strict-aliasing -fno-common -fwrapv -Wold-style-declaration =
-Wold-style-definition -Wtype-limits -Wformat-security -Wformat-y2k -Winit-=
self -Wignored-qualifiers -Wempty-body -Wnested-externs -Wendif-labels -Wex=
pansion-to-defined -Wno-missing-include-dirs -Wno-shift-negative-value -Wno=
-psabi -fstack-protector-strong -DLEGACY_RDMA_REG_MR -isystem /builds/ehabk=
ost/qemu/linux-headers -isystem linux-headers -iquote /builds/ehabkost/qemu=
/tcg/arm -iquote . -iquote /builds/ehabkost/qemu -iquote /builds/ehabkost/q=
emu/accel/tcg -iquote /builds/ehabkost/qemu/include -iquote /builds/ehabkos=
t/qemu/disas/libvixl -pthread -fPIC -isystem../linux-headers -isystemlinux-=
headers -DNEED_CPU_H '-DCONFIG_TARGET=3D"alpha-softmmu-config-target.h"' '-=
DCONFIG_DEVICES=3D"alpha-softmmu-config-devices.h"' -MD -MQ libqemu-alpha-s=
oftmmu.fa.p/monitor_misc.c.o -MF libqemu-alpha-softmmu.fa.p/monitor_misc.c.=
o.d -o libqemu-alpha-softmmu.fa.p/monitor_misc.c.o -c ../monitor/misc.c
../monitor/misc.c: In function 'gpa2hva':
../monitor/misc.c:686:18: error: invalid operands to binary < (have 'Int128=
' {aka 'struct Int128'} and 'uint64_t' {aka 'long long unsigned int'})
     if (mrs.size < size) {
         ~~~~~~~~ ^
[1893/5203] Compiling C object libqemu-alpha-softmmu.fa.p/softmmu_physmem.c=
.o
ninja: build stopped: subcommand failed.

--=20
Eduardo


