Return-Path: <SRS0=LLOU=EL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 181B9C388F7
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Nov 2020 19:54:11 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6009120728
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Nov 2020 19:54:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="b/9lyhZO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6009120728
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49164 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kalKj-00043E-CG
	for qemu-devel@archiver.kernel.org; Thu, 05 Nov 2020 14:54:09 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:34824)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vgoyal@redhat.com>) id 1kalJl-00033x-Fd
 for qemu-devel@nongnu.org; Thu, 05 Nov 2020 14:53:09 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:53711)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <vgoyal@redhat.com>) id 1kalJi-00031z-91
 for qemu-devel@nongnu.org; Thu, 05 Nov 2020 14:53:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1604605984;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=sxiW9LRrFPKZW5DVE75UvguxnnNXMiOaqUQk3K1rXGA=;
 b=b/9lyhZOfitnt0okF/nUb8lO1cbG1mVAFW5AOYCDgD37Pkuk9CDUY5MheiKDQA2ZuHMYiw
 hcyIzqEwB6esz47I2us/q+tEsnoWfvzTl5RMYWgV2dBatinaak+i5xzH22rtcJR8ZBm1it
 uXutnBiLq98uZEEcmT8IJ54w9xiNA3s=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-17-v2bUFG6zNXOCkPzLdva0mg-1; Thu, 05 Nov 2020 14:53:02 -0500
X-MC-Unique: v2bUFG6zNXOCkPzLdva0mg-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id A4ABE1074641;
 Thu,  5 Nov 2020 19:53:01 +0000 (UTC)
Received: from horse.redhat.com (ovpn-115-75.rdu2.redhat.com [10.10.115.75])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 60EA665F5E;
 Thu,  5 Nov 2020 19:52:54 +0000 (UTC)
Received: by horse.redhat.com (Postfix, from userid 10451)
 id DF9832202CA; Thu,  5 Nov 2020 14:52:53 -0500 (EST)
Date: Thu, 5 Nov 2020 14:52:53 -0500
From: Vivek Goyal <vgoyal@redhat.com>
To: qemu-devel@nongnu.org, virtio-fs-list <virtio-fs@redhat.com>
Subject: Re: [Virtio-fs] [PATCH] virtiofsd: Use --thread-pool-size=0 to mean
 no thread pool
Message-ID: <20201105195253.GB1384085@redhat.com>
References: <20201105194416.GA1384085@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20201105194416.GA1384085@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=vgoyal@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Received-SPF: pass client-ip=216.205.24.124; envelope-from=vgoyal@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/11/05 01:14:53
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
Cc: jose.carlos.venegas.munoz@intel.com,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, Nov 05, 2020 at 02:44:16PM -0500, Vivek Goyal wrote:
> Right now we create a thread pool and main thread hands over the request
> to thread in thread pool to process. Number of threads in thread pool
> can be managed by option --thread-pool-size.
> 
> There is a chance that in case of some workloads, we might get better
> performance if we don't handover the request to a different thread
> and process in the context of thread receiving the request.
> 
> To implement that, redefine the meaning of --thread-pool-size=0 to
> mean that don't use a thread pool. Instead process the request in
> the context of thread receiving request from the queue.
> 
> I can't think how --thread-pool-size=0 is useful and hence using
> that. If it is already useful somehow, I could look at defining
> a new option say "--no-thread-pool".
> 
> I think this patch will be used more as a debug help to do comparison
> when it is more effecient to do not hand over the requests to a
> thread pool.

I ran virtiofs-tests to comapre --thread-pool-size=0 and
--thread-pool-size=64. And results seem to be all over the place. In
some cases thread pool seems to perform batter and in other cases
no-thread-pool seems to perform better.

But in general it looks like that except for the case of libaio workload,
no-thread-pool is helping.

Thanks
Vivek

NAME                    WORKLOAD                Bandwidth       IOPS            
thread-pool             seqread-psync           682.4mb         170.6k          
no-thread-pool          seqread-psync           679.3mb         169.8k          

thread-pool             seqread-psync-multi     2415.9mb        603.9k          
no-thread-pool          seqread-psync-multi     2528.5mb        632.1k          

thread-pool             seqread-mmap            591.7mb         147.9k          
no-thread-pool          seqread-mmap            595.6mb         148.9k          

thread-pool             seqread-mmap-multi      2195.3mb        548.8k          
no-thread-pool          seqread-mmap-multi      2286.1mb        571.5k          

thread-pool             seqread-libaio          329.1mb         82.2k           
no-thread-pool          seqread-libaio          271.5mb         67.8k           

thread-pool             seqread-libaio-multi    1387.1mb        346.7k          
no-thread-pool          seqread-libaio-multi    1508.2mb        377.0k          

thread-pool             randread-psync          59.0mb          14.7k           
no-thread-pool          randread-psync          78.5mb          19.6k           

thread-pool             randread-psync-multi    226.4mb         56.6k           
no-thread-pool          randread-psync-multi    289.2mb         72.3k           

thread-pool             randread-mmap           48.4mb          12.1k           
no-thread-pool          randread-mmap           57.4mb          14.3k           

thread-pool             randread-mmap-multi     183.5mb         45.8k           
no-thread-pool          randread-mmap-multi     240.5mb         60.1k           

thread-pool             randread-libaio         329.4mb         82.3k           
no-thread-pool          randread-libaio         261.8mb         65.4k           

thread-pool             randread-libaio-multi   252.1mb         63.0k           
no-thread-pool          randread-libaio-multi   278.3mb         69.5k           

thread-pool             seqwrite-psync          54.9mb          13.7k           
no-thread-pool          seqwrite-psync          77.8mb          19.4k           

thread-pool             seqwrite-psync-multi    219.9mb         54.9k           
no-thread-pool          seqwrite-psync-multi    314.8mb         78.7k           

thread-pool             seqwrite-mmap           191.7mb         47.9k           
no-thread-pool          seqwrite-mmap           201.4mb         50.3k           

thread-pool             seqwrite-mmap-multi     346.6mb         86.6k           
no-thread-pool          seqwrite-mmap-multi     387.6mb         96.9k           

thread-pool             seqwrite-libaio         306.4mb         76.6k           
no-thread-pool          seqwrite-libaio         248.2mb         62.0k           

thread-pool             seqwrite-libaio-multi   328.5mb         82.1k           
no-thread-pool          seqwrite-libaio-multi   305.6mb         76.4k           

thread-pool             randwrite-psync         55.6mb          13.9k           
no-thread-pool          randwrite-psync         81.2mb          20.3k           

thread-pool             randwrite-psync-multi   227.0mb         56.7k           
no-thread-pool          randwrite-psync-multi   311.6mb         77.8k           

thread-pool             randwrite-mmap          35.3mb          9038            
no-thread-pool          randwrite-mmap          58.1mb          14.5k           

thread-pool             randwrite-mmap-multi    140.8mb         35.2k           
no-thread-pool          randwrite-mmap-multi    210.5mb         52.6k           

thread-pool             randwrite-libaio        307.1mb         76.7k           
no-thread-pool          randwrite-libaio        279.4mb         69.8k           

thread-pool             randwrite-libaio-multi  361.3mb         90.3k           
no-thread-pool          randwrite-libaio-multi  302.6mb         75.6k           

thread-pool             randrw-psync            34.1mb/11.4mb   8754/2929       
no-thread-pool          randrw-psync            38.7mb/12.9mb   9919/3321       

thread-pool             randrw-psync-multi      126.2mb/42.3mb  31.5k/10.5k     
no-thread-pool          randrw-psync-multi      172.2mb/57.7mb  43.0k/14.4k     

thread-pool             randrw-mmap             24.1mb/8270kb   6194/2067       
no-thread-pool          randrw-mmap             42.0mb/14.0mb   10.5k/3606      

thread-pool             randrw-mmap-multi       127.9mb/42.8mb  31.9k/10.7k     
no-thread-pool          randrw-mmap-multi       179.4mb/60.0mb  44.8k/15.0k     

thread-pool             randrw-libaio           64.0mb/21.4mb   16.0k/5485      
no-thread-pool          randrw-libaio           79.6mb/26.6mb   19.9k/6831      

thread-pool             randrw-libaio-multi     174.2mb/58.3mb  43.5k/14.5k     
no-thread-pool          randrw-libaio-multi     201.6mb/67.5mb  50.4k/16.8k     


