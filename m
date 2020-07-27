Return-Path: <SRS0=cfdO=BG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4AE76C433E1
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Jul 2020 17:34:31 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0B50420729
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Jul 2020 17:34:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XmIkZBLo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0B50420729
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44498 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k071C-0007Qn-Aq
	for qemu-devel@archiver.kernel.org; Mon, 27 Jul 2020 13:34:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49662)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1k070Q-0006zH-Vj
 for qemu-devel@nongnu.org; Mon, 27 Jul 2020 13:33:43 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:48111
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1k070L-0004bm-0U
 for qemu-devel@nongnu.org; Mon, 27 Jul 2020 13:33:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1595871214;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=0FD42sXIjEiZ5ZZ/4MVgBq5A5IyHDhvt1FXCACkYNmI=;
 b=XmIkZBLo9w9zSARC5oRK72aVOmHDuQjmvNoXhjJ126hyBKU56NA9zwj47yS8h7UP/eX69y
 uJimOlZsD68nKhDkQnVezF8lYr+EqYFT1Wj3S/XO5DRoPyR0xmkV2Y/ppBaJZ5UvyYM6ik
 3ocaKMo0kDE3zdMU2LJawSQKBbPCQTw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-194-Ejyrl7UBObGToMmxe3YKrw-1; Mon, 27 Jul 2020 13:33:31 -0400
X-MC-Unique: Ejyrl7UBObGToMmxe3YKrw-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 298CC801E6A;
 Mon, 27 Jul 2020 17:33:30 +0000 (UTC)
Received: from localhost (unknown [10.40.208.62])
 by smtp.corp.redhat.com (Postfix) with ESMTP id E091D19931;
 Mon, 27 Jul 2020 17:33:28 +0000 (UTC)
Date: Mon, 27 Jul 2020 19:33:26 +0200
From: Igor Mammedov <imammedo@redhat.com>
To: Vishnu Dixit <1888923@bugs.launchpad.net>
Subject: Re: [Bug 1888923] [NEW] Configured Memory access latency and
 bandwidth not taking effect
Message-ID: <20200727193326.03525888@redhat.com>
In-Reply-To: <159566199879.4877.1642879405857907906.malonedeb@wampee.canonical.com>
References: <159566199879.4877.1642879405857907906.malonedeb@wampee.canonical.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=205.139.110.61; envelope-from=imammedo@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/27 01:46:13
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -40
X-Spam_score: -4.1
X-Spam_bar: ----
X-Spam_report: (-4.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1, SPF_HELO_NONE=0.001,
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
Cc: qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Sat, 25 Jul 2020 07:26:38 -0000
Vishnu Dixit <1888923@bugs.launchpad.net> wrote:

> Public bug reported:
>=20
> I was trying to configure latencies and bandwidths between nodes in a
> NUMA emulation using QEMU 5.0.0.
>=20
> Host : Ubuntu 20.04 64 bit
> Guest : Ubuntu 18.04 64 bit
>=20
> The machine configured has 2 nodes. Each node has 2 CPUs and has been
> allocated 3GB of memory. The memory access latencies and bandwidths for
> a local access (i.e from initiator 0 to target 0, and from initiator 1
> to target 1) are set as 40ns and 10GB/s respectively. The memory access
> latencies and bandwidths for a remote access (i.e from initiator 1 to
> target 0, and from initiator 0 to target 1) are set as 80ns and 5GB/s
> respectively.
>=20
> The command line launch is as follows.
>=20
> sudo x86_64-softmmu/qemu-system-x86_64  \
> -machine hmat=3Don \
> -boot c \
> -enable-kvm \
> -m 6G,slots=3D2,maxmem=3D7G \
> -object memory-backend-ram,size=3D3G,id=3Dm0 \
> -object memory-backend-ram,size=3D3G,id=3Dm1 \
> -numa node,nodeid=3D0,memdev=3Dm0 \
> -numa node,nodeid=3D1,memdev=3Dm1 \
> -smp 4,sockets=3D4,maxcpus=3D4  \
> -numa cpu,node-id=3D0,socket-id=3D0 \
> -numa cpu,node-id=3D0,socket-id=3D1 \
> -numa cpu,node-id=3D1,socket-id=3D2 \
> -numa cpu,node-id=3D1,socket-id=3D3 \
> -numa dist,src=3D0,dst=3D1,val=3D20 \
> -net nic \
> -net user \
> -hda testing.img \
> -numa hmat-lb,initiator=3D0,target=3D0,hierarchy=3Dmemory,data-type=3Dacc=
ess-latency,latency=3D40 \
> -numa hmat-lb,initiator=3D0,target=3D0,hierarchy=3Dmemory,data-type=3Dacc=
ess-bandwidth,bandwidth=3D10G \
> -numa hmat-lb,initiator=3D0,target=3D1,hierarchy=3Dmemory,data-type=3Dacc=
ess-latency,latency=3D80 \
> -numa hmat-lb,initiator=3D0,target=3D1,hierarchy=3Dmemory,data-type=3Dacc=
ess-bandwidth,bandwidth=3D5G \
> -numa hmat-lb,initiator=3D1,target=3D0,hierarchy=3Dmemory,data-type=3Dacc=
ess-latency,latency=3D80 \
> -numa hmat-lb,initiator=3D1,target=3D0,hierarchy=3Dmemory,data-type=3Dacc=
ess-bandwidth,bandwidth=3D5G \
> -numa hmat-lb,initiator=3D1,target=3D1,hierarchy=3Dmemory,data-type=3Dacc=
ess-latency,latency=3D40 \
> -numa hmat-lb,initiator=3D1,target=3D1,hierarchy=3Dmemory,data-type=3Dacc=
ess-bandwidth,bandwidth=3D10G \
>=20
> Then the latencies and bandwidths between the nodes were tested using
> the Intel Memory Latency Checker v3.9
> (https://software.intel.com/content/www/us/en/develop/articles/intelr-
> memory-latency-checker.html). But the obtained results did not match the
> configuration. The following are the results obtained.
>=20
> Latency_matrix with idle latencies (in ns)
>=20
> Numa Node
> . .0. . .1.
> 0 36.2 36.4
> 1 34.9 35.4
>=20
> Bandwidth_matrix with memory bandwidths (in MB/s)
>=20
> Numa Node
> . . .0. . . .1.=20
> 0 15167.1 15308.9
> 1 15226.0 15234.0
>=20
> A test was also conducted with the tool =E2=80=9Clat_mem_rd=E2=80=9D from=
 lmbench to
> measure the memory read latencies. This also gave results which did not
> match the config.
>=20
> Any information on why the config latency and bandwidth values are not
> applied, would be appreciated.

There is no information about host hardware, so I'd onldy hazard a guess
that host is non NUMA machine so all guest RAM and CPUs are in the same
latency domain, so that's why you are seeing pretty much the same timings.

QEMU nor KMV do not simullate HW latencies at all, all that is configured
with '-numa hmat-lb' is intended for guest OS consumption as a hint for
smarter memory allocation and it's on to user to pin CPUs and RAM to
concrete host NUMA nodes and use  host's values in '-numa hmat-lb' to
actually get performance benefits from it on 'NUMA' machine.
On non NUMA host it's rather pointless except of the cases where one
needs to fake NUMA config (like testing some aspects of NUMA related code
in guest OS).

>=20
> ** Affects: qemu
>      Importance: Undecided
>          Status: New
>=20
>=20
> ** Tags: bandwidth hmat hmat-lb latency
>=20
> ** Description changed:
>=20
>   I was trying to configure latencies and bandwidths between nodes in a
>   NUMA emulation using QEMU 5.0.0.
>  =20
>   Host : Ubuntu 20.04 64 bit
>   Guest : Ubuntu 18.04 64 bit
> - =20
> - The machine configured has 2 nodes. Each node has 2 CPUs and has been a=
llocated 3GB of memory. The memory access latencies and bandwidths for a lo=
cal access (i.e from initiator 0 to target 0, and from initiator 1 to targe=
t 1) are set as 40ns and 10GB/s respectively. The memory access latencies a=
nd bandwidths for a remote access (i.e from initiator 1 to target 0, and fr=
om initiator 0 to target 1) are set as 80ns and 5GB/s respectively.=20
> +=20
> + The machine configured has 2 nodes. Each node has 2 CPUs and has been
> + allocated 3GB of memory. The memory access latencies and bandwidths for
> + a local access (i.e from initiator 0 to target 0, and from initiator 1
> + to target 1) are set as 40ns and 10GB/s respectively. The memory access
> + latencies and bandwidths for a remote access (i.e from initiator 1 to
> + target 0, and from initiator 0 to target 1) are set as 80ns and 5GB/s
> + respectively.
>  =20
>   The command line launch is as follows.
>  =20
>   sudo x86_64-softmmu/qemu-system-x86_64  \
>   -machine hmat=3Don \
>   -boot c \
>   -enable-kvm \
>   -m 6G,slots=3D2,maxmem=3D7G \
>   -object memory-backend-ram,size=3D3G,id=3Dm0 \
>   -object memory-backend-ram,size=3D3G,id=3Dm1 \
>   -numa node,nodeid=3D0,memdev=3Dm0 \
>   -numa node,nodeid=3D1,memdev=3Dm1 \
>   -smp 4,sockets=3D4,maxcpus=3D4  \
>   -numa cpu,node-id=3D0,socket-id=3D0 \
>   -numa cpu,node-id=3D0,socket-id=3D1 \
>   -numa cpu,node-id=3D1,socket-id=3D2 \
>   -numa cpu,node-id=3D1,socket-id=3D3 \
>   -numa dist,src=3D0,dst=3D1,val=3D20 \
>   -net nic \
>   -net user \
>   -hda testing.img \
>   -numa hmat-lb,initiator=3D0,target=3D0,hierarchy=3Dmemory,data-type=3Da=
ccess-latency,latency=3D40 \
>   -numa hmat-lb,initiator=3D0,target=3D0,hierarchy=3Dmemory,data-type=3Da=
ccess-bandwidth,bandwidth=3D10G \
>   -numa hmat-lb,initiator=3D0,target=3D1,hierarchy=3Dmemory,data-type=3Da=
ccess-latency,latency=3D80 \
>   -numa hmat-lb,initiator=3D0,target=3D1,hierarchy=3Dmemory,data-type=3Da=
ccess-bandwidth,bandwidth=3D5G \
>   -numa hmat-lb,initiator=3D1,target=3D0,hierarchy=3Dmemory,data-type=3Da=
ccess-latency,latency=3D80 \
>   -numa hmat-lb,initiator=3D1,target=3D0,hierarchy=3Dmemory,data-type=3Da=
ccess-bandwidth,bandwidth=3D5G \
>   -numa hmat-lb,initiator=3D1,target=3D1,hierarchy=3Dmemory,data-type=3Da=
ccess-latency,latency=3D40 \
>   -numa hmat-lb,initiator=3D1,target=3D1,hierarchy=3Dmemory,data-type=3Da=
ccess-bandwidth,bandwidth=3D10G \
>  =20
>   Then the latencies and bandwidths between the nodes were tested using
>   the Intel Memory Latency Checker v3.9
>   (https://software.intel.com/content/www/us/en/develop/articles/intelr-
>   memory-latency-checker.html). But the obtained results did not match th=
e
>   configuration. The following are the results obtained.
>  =20
>   Latency_matrix with idle latencies (in ns)
>  =20
>   Numa
> - Node  0     1
> + lat node0 node1
>   0    36.2 36.4
>   1    34.9 35.4
>  =20
>   Bandwidth_matrix with memory bandwidths (in MB/s)
>  =20
> - Numa
> - Node 0       1
> + Numa Node=20
> + bw node0 .bw node1
>   0 15167.1 15308.9
>   1 15226.0 15234.0
>  =20
>   A test was also conducted with the tool =E2=80=9Clat_mem_rd=E2=80=9D fr=
om lmbench to
>   measure the memory read latencies. This also gave results which did not
>   match the config.
>  =20
>   Any information on why the config latency and bandwidth values are not
>   applied, would be appreciated.
>=20
> ** Description changed:
>=20
>   I was trying to configure latencies and bandwidths between nodes in a
>   NUMA emulation using QEMU 5.0.0.
>  =20
>   Host : Ubuntu 20.04 64 bit
>   Guest : Ubuntu 18.04 64 bit
>  =20
>   The machine configured has 2 nodes. Each node has 2 CPUs and has been
>   allocated 3GB of memory. The memory access latencies and bandwidths for
>   a local access (i.e from initiator 0 to target 0, and from initiator 1
>   to target 1) are set as 40ns and 10GB/s respectively. The memory access
>   latencies and bandwidths for a remote access (i.e from initiator 1 to
>   target 0, and from initiator 0 to target 1) are set as 80ns and 5GB/s
>   respectively.
>  =20
>   The command line launch is as follows.
>  =20
>   sudo x86_64-softmmu/qemu-system-x86_64  \
>   -machine hmat=3Don \
>   -boot c \
>   -enable-kvm \
>   -m 6G,slots=3D2,maxmem=3D7G \
>   -object memory-backend-ram,size=3D3G,id=3Dm0 \
>   -object memory-backend-ram,size=3D3G,id=3Dm1 \
>   -numa node,nodeid=3D0,memdev=3Dm0 \
>   -numa node,nodeid=3D1,memdev=3Dm1 \
>   -smp 4,sockets=3D4,maxcpus=3D4  \
>   -numa cpu,node-id=3D0,socket-id=3D0 \
>   -numa cpu,node-id=3D0,socket-id=3D1 \
>   -numa cpu,node-id=3D1,socket-id=3D2 \
>   -numa cpu,node-id=3D1,socket-id=3D3 \
>   -numa dist,src=3D0,dst=3D1,val=3D20 \
>   -net nic \
>   -net user \
>   -hda testing.img \
>   -numa hmat-lb,initiator=3D0,target=3D0,hierarchy=3Dmemory,data-type=3Da=
ccess-latency,latency=3D40 \
>   -numa hmat-lb,initiator=3D0,target=3D0,hierarchy=3Dmemory,data-type=3Da=
ccess-bandwidth,bandwidth=3D10G \
>   -numa hmat-lb,initiator=3D0,target=3D1,hierarchy=3Dmemory,data-type=3Da=
ccess-latency,latency=3D80 \
>   -numa hmat-lb,initiator=3D0,target=3D1,hierarchy=3Dmemory,data-type=3Da=
ccess-bandwidth,bandwidth=3D5G \
>   -numa hmat-lb,initiator=3D1,target=3D0,hierarchy=3Dmemory,data-type=3Da=
ccess-latency,latency=3D80 \
>   -numa hmat-lb,initiator=3D1,target=3D0,hierarchy=3Dmemory,data-type=3Da=
ccess-bandwidth,bandwidth=3D5G \
>   -numa hmat-lb,initiator=3D1,target=3D1,hierarchy=3Dmemory,data-type=3Da=
ccess-latency,latency=3D40 \
>   -numa hmat-lb,initiator=3D1,target=3D1,hierarchy=3Dmemory,data-type=3Da=
ccess-bandwidth,bandwidth=3D10G \
>  =20
>   Then the latencies and bandwidths between the nodes were tested using
>   the Intel Memory Latency Checker v3.9
>   (https://software.intel.com/content/www/us/en/develop/articles/intelr-
>   memory-latency-checker.html). But the obtained results did not match th=
e
>   configuration. The following are the results obtained.
>  =20
>   Latency_matrix with idle latencies (in ns)
>  =20
> - Numa
> + Numa Node
>   lat node0 node1
>   0    36.2 36.4
>   1    34.9 35.4
>  =20
>   Bandwidth_matrix with memory bandwidths (in MB/s)
>  =20
> - Numa Node=20
> - bw node0 .bw node1
> + Numa Node
> + bw node0  bw node1
>   0 15167.1 15308.9
>   1 15226.0 15234.0
>  =20
>   A test was also conducted with the tool =E2=80=9Clat_mem_rd=E2=80=9D fr=
om lmbench to
>   measure the memory read latencies. This also gave results which did not
>   match the config.
>  =20
>   Any information on why the config latency and bandwidth values are not
>   applied, would be appreciated.
>=20
> ** Description changed:
>=20
>   I was trying to configure latencies and bandwidths between nodes in a
>   NUMA emulation using QEMU 5.0.0.
>  =20
>   Host : Ubuntu 20.04 64 bit
>   Guest : Ubuntu 18.04 64 bit
>  =20
>   The machine configured has 2 nodes. Each node has 2 CPUs and has been
>   allocated 3GB of memory. The memory access latencies and bandwidths for
>   a local access (i.e from initiator 0 to target 0, and from initiator 1
>   to target 1) are set as 40ns and 10GB/s respectively. The memory access
>   latencies and bandwidths for a remote access (i.e from initiator 1 to
>   target 0, and from initiator 0 to target 1) are set as 80ns and 5GB/s
>   respectively.
>  =20
>   The command line launch is as follows.
>  =20
>   sudo x86_64-softmmu/qemu-system-x86_64  \
>   -machine hmat=3Don \
>   -boot c \
>   -enable-kvm \
>   -m 6G,slots=3D2,maxmem=3D7G \
>   -object memory-backend-ram,size=3D3G,id=3Dm0 \
>   -object memory-backend-ram,size=3D3G,id=3Dm1 \
>   -numa node,nodeid=3D0,memdev=3Dm0 \
>   -numa node,nodeid=3D1,memdev=3Dm1 \
>   -smp 4,sockets=3D4,maxcpus=3D4  \
>   -numa cpu,node-id=3D0,socket-id=3D0 \
>   -numa cpu,node-id=3D0,socket-id=3D1 \
>   -numa cpu,node-id=3D1,socket-id=3D2 \
>   -numa cpu,node-id=3D1,socket-id=3D3 \
>   -numa dist,src=3D0,dst=3D1,val=3D20 \
>   -net nic \
>   -net user \
>   -hda testing.img \
>   -numa hmat-lb,initiator=3D0,target=3D0,hierarchy=3Dmemory,data-type=3Da=
ccess-latency,latency=3D40 \
>   -numa hmat-lb,initiator=3D0,target=3D0,hierarchy=3Dmemory,data-type=3Da=
ccess-bandwidth,bandwidth=3D10G \
>   -numa hmat-lb,initiator=3D0,target=3D1,hierarchy=3Dmemory,data-type=3Da=
ccess-latency,latency=3D80 \
>   -numa hmat-lb,initiator=3D0,target=3D1,hierarchy=3Dmemory,data-type=3Da=
ccess-bandwidth,bandwidth=3D5G \
>   -numa hmat-lb,initiator=3D1,target=3D0,hierarchy=3Dmemory,data-type=3Da=
ccess-latency,latency=3D80 \
>   -numa hmat-lb,initiator=3D1,target=3D0,hierarchy=3Dmemory,data-type=3Da=
ccess-bandwidth,bandwidth=3D5G \
>   -numa hmat-lb,initiator=3D1,target=3D1,hierarchy=3Dmemory,data-type=3Da=
ccess-latency,latency=3D40 \
>   -numa hmat-lb,initiator=3D1,target=3D1,hierarchy=3Dmemory,data-type=3Da=
ccess-bandwidth,bandwidth=3D10G \
>  =20
>   Then the latencies and bandwidths between the nodes were tested using
>   the Intel Memory Latency Checker v3.9
>   (https://software.intel.com/content/www/us/en/develop/articles/intelr-
>   memory-latency-checker.html). But the obtained results did not match th=
e
>   configuration. The following are the results obtained.
>  =20
>   Latency_matrix with idle latencies (in ns)
>  =20
>   Numa Node
> - lat node0 node1
> - 0    36.2 36.4
> - 1    34.9 35.4
> + . .0. . .1.
> + 0 36.2 36.4
> + 1 34.9 35.4
>  =20
>   Bandwidth_matrix with memory bandwidths (in MB/s)
>  =20
>   Numa Node
> - bw node0  bw node1
> + . . .0. . . .1.=20
>   0 15167.1 15308.9
>   1 15226.0 15234.0
>  =20
>   A test was also conducted with the tool =E2=80=9Clat_mem_rd=E2=80=9D fr=
om lmbench to
>   measure the memory read latencies. This also gave results which did not
>   match the config.
>  =20
>   Any information on why the config latency and bandwidth values are not
>   applied, would be appreciated.
>=20


