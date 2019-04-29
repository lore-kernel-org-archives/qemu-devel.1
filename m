Return-Path: <SRS0=sEuR=S7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,T_HK_NAME_DR,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DAEABC43219
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Apr 2019 12:25:55 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id ADE432087B
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Apr 2019 12:25:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ADE432087B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:56955 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hL5M2-0000iD-SU
	for qemu-devel@archiver.kernel.org; Mon, 29 Apr 2019 08:25:54 -0400
Received: from eggs.gnu.org ([209.51.188.92]:43986)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1hL5LF-0000LQ-Te
	for qemu-devel@nongnu.org; Mon, 29 Apr 2019 08:25:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1hL5LE-000375-U9
	for qemu-devel@nongnu.org; Mon, 29 Apr 2019 08:25:05 -0400
Received: from mx1.redhat.com ([209.132.183.28]:32828)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1hL5LE-00036R-M7
	for qemu-devel@nongnu.org; Mon, 29 Apr 2019 08:25:04 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
	[10.5.11.16])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id E18598762B;
	Mon, 29 Apr 2019 12:25:03 +0000 (UTC)
Received: from work-vm (ovpn-117-192.ams2.redhat.com [10.36.117.192])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 6BE5569705;
	Mon, 29 Apr 2019 12:25:02 +0000 (UTC)
Date: Mon, 29 Apr 2019 13:25:00 +0100
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
To: Zhang Chen <chen.zhang@intel.com>
Message-ID: <20190429122459.GG2748@work-vm>
References: <20190426090730.2691-1-chen.zhang@intel.com>
	<20190426090730.2691-4-chen.zhang@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
In-Reply-To: <20190426090730.2691-4-chen.zhang@intel.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.26]);
	Mon, 29 Apr 2019 12:25:03 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH 3/3] qemu-option.hx: Update missed
 parameter for colo-compare
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
Cc: zhanghailiang <zhang.zhanghailiang@huawei.com>,
	Juan Quintela <quintela@redhat.com>, qemu-dev <qemu-devel@nongnu.org>,
	Markus Armbruster <armbru@redhat.com>, Zhang Chen <zhangckid@gmail.com>,
	Laurent Vivier <laurent@vivier.eu>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190429122500.HQEh5fH06DwbDgpjJYutg-hemSc82Fu6UAToE8f4pqQ@z>

* Zhang Chen (chen.zhang@intel.com) wrote:
> From: Zhang Chen <chen.zhang@intel.com>
> 
> We missed the iothread related args in this file.
> This patch is used to fix this issue.
> 
> Signed-off-by: Zhang Chen <chen.zhang@intel.com>

OK.


Reviewed-by: Dr. David Alan Gilbert <dgilbert@redhat.com>

> ---
>  qemu-options.hx | 9 ++++++---
>  1 file changed, 6 insertions(+), 3 deletions(-)
> 
> diff --git a/qemu-options.hx b/qemu-options.hx
> index 08749a3391..a4500c99ef 100644
> --- a/qemu-options.hx
> +++ b/qemu-options.hx
> @@ -4420,13 +4420,15 @@ Dump the network traffic on netdev @var{dev} to the file specified by
>  The file format is libpcap, so it can be analyzed with tools such as tcpdump
>  or Wireshark.
>  
> -@item -object colo-compare,id=@var{id},primary_in=@var{chardevid},secondary_in=@var{chardevid},outdev=@var{chardevid}[,vnet_hdr_support]
> +@item -object colo-compare,id=@var{id},primary_in=@var{chardevid},secondary_in=@var{chardevid},outdev=@var{chardevid},iothread=@var{id}[,vnet_hdr_support]
>  
>  Colo-compare gets packet from primary_in@var{chardevid} and secondary_in@var{chardevid}, than compare primary packet with
>  secondary packet. If the packets are same, we will output primary
>  packet to outdev@var{chardevid}, else we will notify colo-frame
>  do checkpoint and send primary packet to outdev@var{chardevid}.
> -if it has the vnet_hdr_support flag, colo compare will send/recv packet with vnet_hdr_len.
> +In order to improve efficiency, we need to put the task of comparison
> +in another thread. If it has the vnet_hdr_support flag, colo compare
> +will send/recv packet with vnet_hdr_len.
>  
>  we must use it with the help of filter-mirror and filter-redirector.
>  
> @@ -4441,10 +4443,11 @@ primary:
>  -chardev socket,id=compare0-0,host=3.3.3.3,port=9001
>  -chardev socket,id=compare_out,host=3.3.3.3,port=9005,server,nowait
>  -chardev socket,id=compare_out0,host=3.3.3.3,port=9005
> +-object iothread,id=iothread1
>  -object filter-mirror,id=m0,netdev=hn0,queue=tx,outdev=mirror0
>  -object filter-redirector,netdev=hn0,id=redire0,queue=rx,indev=compare_out
>  -object filter-redirector,netdev=hn0,id=redire1,queue=rx,outdev=compare0
> --object colo-compare,id=comp0,primary_in=compare0-0,secondary_in=compare1,outdev=compare_out0
> +-object colo-compare,id=comp0,primary_in=compare0-0,secondary_in=compare1,outdev=compare_out0,iothread=iothread1
>  
>  secondary:
>  -netdev tap,id=hn0,vhost=off,script=/etc/qemu-ifup,down script=/etc/qemu-ifdown
> -- 
> 2.17.GIT
> 
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK

