Return-Path: <SRS0=gOAu=AP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4DFAFC433DF
	for <qemu-devel@archiver.kernel.org>; Sat,  4 Jul 2020 18:47:18 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1A09C20771
	for <qemu-devel@archiver.kernel.org>; Sat,  4 Jul 2020 18:47:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Ik9Zcy3d"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1A09C20771
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44428 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jrnC1-0001cY-8k
	for qemu-devel@archiver.kernel.org; Sat, 04 Jul 2020 14:47:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40668)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1jrmzN-0002SM-HO
 for qemu-devel@nongnu.org; Sat, 04 Jul 2020 14:34:13 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:49208
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1jrmzL-00026L-Nc
 for qemu-devel@nongnu.org; Sat, 04 Jul 2020 14:34:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1593887651;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=cjzZWxnnykq05TtdjmaRFa55dc9c5bd35Z/S8rumoHc=;
 b=Ik9Zcy3dg98CP6v3E9il4UU7/yYZ+zdvYii+46o5BDiQvi9PxXDs8JCsNKELhLbKfBnNFx
 bWeMZsL7wOEBlYX55GDusTIqTawGNs90t27uB/9GQIZcGvjc/ZvM1vxqD7tb8bJQf8yjKc
 WoaFCCsLx8Yu8dmhEueeZfI2QuCTXM8=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-241-bkvge0pENIGthhw1pd_WFw-1; Sat, 04 Jul 2020 14:34:09 -0400
X-MC-Unique: bkvge0pENIGthhw1pd_WFw-1
Received: by mail-wm1-f70.google.com with SMTP id v24so40251086wmh.3
 for <qemu-devel@nongnu.org>; Sat, 04 Jul 2020 11:34:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=cjzZWxnnykq05TtdjmaRFa55dc9c5bd35Z/S8rumoHc=;
 b=l9tLWinNQJPjvbXRUrFN1OH4/2Ax283vUWhU5F9HG7wh+QEtLGgu2P2AirzNTwi5Ov
 +d9gXejMc3H03umrxOPZz7kcp0FwwTo9vi8RUU8A1G1gGlaksoPdZgfHnLKrd5zxyLpf
 0XgH+iDnaNBTM8pUr6WXwYR1gi6cSrw/a/3mHO65bQ66rEct+DyOFTGw3llRCde4vebp
 gYs1bs4RTrEpcxk9HOibwNDNla4B/AnvJqPBt1s7h+lclxpvM+io/tHX4J6SJGiALC3U
 VXWqlO9k97jvFKQfnDbgGCOAzsfnRtH9raCk2ZAyOF6F7+LLqlh4x5gbG1p2Jr0l6Wef
 taQA==
X-Gm-Message-State: AOAM533VhL/3KP5urX/tam9VBTRChpuAqsvsjAF539QQ820187ri6VRF
 nB2SlQJKTpHRvKc1AnJOiLTZkE06DAiX0O4to6MMZqUuyECeCXn9ntTj8XNHweHkT9X8kU+bb3G
 YEsInuZOOfGMDr20=
X-Received: by 2002:a1c:dd86:: with SMTP id
 u128mr41891253wmg.123.1593887647998; 
 Sat, 04 Jul 2020 11:34:07 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJx+hxeVv9tyaPjISHwSpdkExcuyq92d2WV1GUELBTtxzAm0ZJ+X1l2dd6Kqevu7loZ8P/3jeA==
X-Received: by 2002:a1c:dd86:: with SMTP id
 u128mr41891236wmg.123.1593887647826; 
 Sat, 04 Jul 2020 11:34:07 -0700 (PDT)
Received: from redhat.com (bzq-79-182-31-92.red.bezeqint.net. [79.182.31.92])
 by smtp.gmail.com with ESMTPSA id
 v6sm5249119wrr.85.2020.07.04.11.34.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 04 Jul 2020 11:34:07 -0700 (PDT)
Date: Sat, 4 Jul 2020 14:34:04 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Halil Pasic <pasic@linux.ibm.com>
Subject: Re: [PATCH 1/2] virtio-ccw: fix virtio_set_ind_atomic
Message-ID: <20200704143126-mutt-send-email-mst@kernel.org>
References: <20200616045035.51641-1-pasic@linux.ibm.com>
 <20200616045035.51641-2-pasic@linux.ibm.com>
MIME-Version: 1.0
In-Reply-To: <20200616045035.51641-2-pasic@linux.ibm.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mst@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Received-SPF: pass client-ip=207.211.31.120; envelope-from=mst@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/04 11:39:14
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: Thomas Huth <thuth@redhat.com>, Matthew Rosato <mjrosato@linux.ibm.com>,
 David Hildenbrand <david@redhat.com>, Cornelia Huck <cohuck@redhat.com>,
 qemu-devel@nongnu.org, Christian Borntraeger <borntraeger@de.ibm.com>,
 qemu-s390x@nongnu.org, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, Jun 16, 2020 at 06:50:34AM +0200, Halil Pasic wrote:
> The atomic_cmpxchg() loop is broken because we occasionally end up with
> old and _old having different values (a legit compiler can generate code
> that accessed *ind_addr again to pick up a value for _old instead of
> using the value of old that was already fetched according to the
> rules of the abstract machine). This means the underlying CS instruction
> may use a different old (_old) than the one we intended to use if
> atomic_cmpxchg() performed the xchg part.

And was this ever observed in the field? Or is this a theoretical issue?
commit log should probably say ...

> 
> Let us use volatile to force the rules of the abstract machine for
> accesses to *ind_addr. Let us also rewrite the loop so, we that the

we that -> we know that?

> new old is used to compute the new desired value if the xchg part
> is not performed.
> 
> Signed-off-by: Halil Pasic <pasic@linux.ibm.com>
> Reported-by: Andre Wild <Andre.Wild1@ibm.com>
> Fixes: 7e7494627f ("s390x/virtio-ccw: Adapter interrupt support.")
> ---
>  hw/s390x/virtio-ccw.c | 18 ++++++++++--------
>  1 file changed, 10 insertions(+), 8 deletions(-)
> 
> diff --git a/hw/s390x/virtio-ccw.c b/hw/s390x/virtio-ccw.c
> index c1f4bb1d33..3c988a000b 100644
> --- a/hw/s390x/virtio-ccw.c
> +++ b/hw/s390x/virtio-ccw.c
> @@ -786,9 +786,10 @@ static inline VirtioCcwDevice *to_virtio_ccw_dev_fast(DeviceState *d)
>  static uint8_t virtio_set_ind_atomic(SubchDev *sch, uint64_t ind_loc,
>                                       uint8_t to_be_set)
>  {
> -    uint8_t ind_old, ind_new;
> +    uint8_t expected, actual;
>      hwaddr len = 1;
> -    uint8_t *ind_addr;
> +    /* avoid  multiple fetches */
> +    uint8_t volatile *ind_addr;
>  
>      ind_addr = cpu_physical_memory_map(ind_loc, &len, true);
>      if (!ind_addr) {
> @@ -796,14 +797,15 @@ static uint8_t virtio_set_ind_atomic(SubchDev *sch, uint64_t ind_loc,
>                       __func__, sch->cssid, sch->ssid, sch->schid);
>          return -1;
>      }
> +    actual = *ind_addr;
>      do {
> -        ind_old = *ind_addr;
> -        ind_new = ind_old | to_be_set;
> -    } while (atomic_cmpxchg(ind_addr, ind_old, ind_new) != ind_old);
> -    trace_virtio_ccw_set_ind(ind_loc, ind_old, ind_new);
> -    cpu_physical_memory_unmap(ind_addr, len, 1, len);
> +        expected = actual;
> +        actual = atomic_cmpxchg(ind_addr, expected, expected | to_be_set);
> +    } while (actual != expected);
> +    trace_virtio_ccw_set_ind(ind_loc, actual, actual | to_be_set);
> +    cpu_physical_memory_unmap((void *)ind_addr, len, 1, len);
>  
> -    return ind_old;
> +    return actual;
>  }

I wonder whether cpuXX APIs should accept volatile pointers, too:
casting away volatile is always suspicious.
But that is a separate issue ...

>  static void virtio_ccw_notify(DeviceState *d, uint16_t vector)
> -- 
> 2.17.1


