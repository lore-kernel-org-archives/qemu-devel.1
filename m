Return-Path: <SRS0=JPH5=CC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED1FEC433E1
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Aug 2020 17:46:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9D22D206BE
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Aug 2020 17:46:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Y0El1HoA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9D22D206BE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39190 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kAGY1-0002oB-Qu
	for qemu-devel@archiver.kernel.org; Mon, 24 Aug 2020 13:46:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47992)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dgilbert@redhat.com>)
 id 1kAGXG-0002NV-66
 for qemu-devel@nongnu.org; Mon, 24 Aug 2020 13:45:34 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:55354)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <dgilbert@redhat.com>)
 id 1kAGXC-0001QL-OS
 for qemu-devel@nongnu.org; Mon, 24 Aug 2020 13:45:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1598291129;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=y6OmUOzh+mK9H+ZTbHkX53PTsBnNacRAP9rzYpfBOeU=;
 b=Y0El1HoArV0kZS9BmA7BjO+A81zvw0lcV33qPO7T1ECiZrevFrn0Ets1x84LOOirpjCkKd
 7p5nyPCGuLU5w+i7BFr+F1HzLKTXHULK6AG2OPWCj2P8xwQzGrOqfGUaxLRw3j3efdZ7gT
 CIkaR8nlhPYjZVENeELIwJ83JWOXID4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-197-8AZuBQ_pOoKzOgNjASLAKQ-1; Mon, 24 Aug 2020 13:45:26 -0400
X-MC-Unique: 8AZuBQ_pOoKzOgNjASLAKQ-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id E6F3110082E6;
 Mon, 24 Aug 2020 17:45:24 +0000 (UTC)
Received: from work-vm (ovpn-114-59.ams2.redhat.com [10.36.114.59])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 04AA05BAC3;
 Mon, 24 Aug 2020 17:45:23 +0000 (UTC)
Date: Mon, 24 Aug 2020 18:45:21 +0100
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
To: Pedro Serrano <kpiq@gmx.us>
Subject: Re: unknown fs driver type 'virtiofs'
Message-ID: <20200824174521.GA2688@work-vm>
References: <trinity-3bf6c693-675f-4587-a673-717b058ceb06-1598236839217@3c-app-mailcom-bs08>
MIME-Version: 1.0
In-Reply-To: <trinity-3bf6c693-675f-4587-a673-717b058ceb06-1598236839217@3c-app-mailcom-bs08>
User-Agent: Mutt/1.14.6 (2020-07-11)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=dgilbert@redhat.com
X-Mimecast-Spam-Score: 0.002
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Received-SPF: pass client-ip=216.205.24.124; envelope-from=dgilbert@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/24 04:38:05
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.956,
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
Cc: stefanha@gmail.com, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

* Pedro Serrano (kpiq@gmx.us) wrote:
> <html><head></head><body><div style="font-family: Verdana;font-size: 12.0px;"><pre>Folks
> 
> The instructions posted on <a href="http://blog.vmsplice.net/2020/04/virtio-fs-has-landed-in-qemu-50.html" target="_blank">http://blog.vmsplice.net/2020/04/virtio-fs-has-landed-in-qemu-50.html</a> are simple and I followed them.
> 
> I&#39;ve updated my Debian Buster QEMU and LIBVIRT packages to all the newest buster-backports versions, and am running on:
> 
> Linux ps01ubx 5.7.0-0.bpo.2-amd64 #1 SMP Debian 5.7.10-1~bpo10+1 (2020-07-30) x86_64 GNU/Linux
> 
> lsmod&#124;grep virtio
> virtiofs               32768  0
> virtio_ring            36864  1 virtiofs
> virtio                 16384  1 virtiofs
> fuse                  139264  4 virtiofs
> 
> dpkg -l gir1.2-libvirt-glib-1.0:amd64 ipxe-qemu libvirglrenderer0:amd64 libvirt-clients libvirt-daemon libvirt-daemon-system libvirt-glib-1.0-0:amd64 libvirt0:amd64 python3-libvirt qemu qemu-block-extra qemu-system-common qemu-system-data qemu-system-gui:amd64 qemu-system-x86 qemu-utils
> Desired=Unknown/Install/Remove/Purge/Hold
> &#124; Status=Not/Inst/Conf-files/Unpacked/halF-conf/Half-inst/trig-aWait/Trig-pend
> &#124;/ Err?=(none)/Reinst-required (Status,Err: uppercase=bad)
> &#124;&#124;/ Name                          Version                      Architecture Desc
> +++-=============================-============================-============-====
> ii  gir1.2-libvirt-glib-1.0:amd64 1.0.0-1                      amd64        GObj
> ii  ipxe-qemu                     1.0.0+git-20190125.36a4c85-1 all          PXE 
> ii  libvirglrenderer0:amd64       0.7.0-2                      amd64        virt
> ii  libvirt-clients               5.0.0-4+deb10u1              amd64        Prog
> ii  libvirt-daemon                5.0.0-4+deb10u1              amd64        Virt
> ii  libvirt-daemon-system         5.0.0-4+deb10u1              amd64        Libv
> ii  libvirt-glib-1.0-0:amd64      1.0.0-1                      amd64        libv
> ii  libvirt0:amd64                5.0.0-4+deb10u1              amd64        libr
> ii  python3-libvirt               5.0.0-1                      amd64        libv
> ii  qemu                          1:5.0-14~bpo10+1             amd64        fast
> ii  qemu-block-extra              1:5.0-14~bpo10+1             amd64        extr
> ii  qemu-system-common            1:5.0-14~bpo10+1             amd64        QEMU
> ii  qemu-system-data              1:5.0-14~bpo10+1             all          QEMU
> ii  qemu-system-gui:amd64         1:5.0-14~bpo10+1             amd64        QEMU
> ii  qemu-system-x86               1:5.0-14~bpo10+1             amd64        QEMU
> ii  qemu-utils                    1:5.0-14~bpo10+1             amd64        QEMU
> 
> Whenever I add a filesystem to the vm xml (virsh edit vm) virt-manager spits out an error message.  Because virt-manager doesn&#39;t have a &quot;virtiofs&quot; line in the drop-down choices I first choose &quot;PATH&quot; and then try to change the XML.
> 
>     &lt;filesystem type=&#39;mount&#39; accessmode=&#39;passthrough&#39;&gt;
>       &lt;driver type=&#39;virtiofs&#39;/&gt;</pre>
> 
>  
> 
> The result is similar, whether I use virt-manager or virsh edit vm:
> 

I think your libvirt is too old; my reckoning is it went in v6.1.0 (or
was it 6.2.0?)

> virtio-manager replies: unknown fs driver type &#39;virtiofs&#39;
> 
> virsh edit vm does not let me save the file.   It replies:   
> error: XML document failed to validate against schema: Unable to validate doc against /usr/share/libvirt/schemas/domain.rng<br/>
> Extra element devices in interleave<br/>
> Element domain failed to validate content
> 
> Failed. Try again? [y,n,i,f,?]: 
> 
> 
> What am I doing wrong?

You're also using HTML mail without plaintext!

Dave

> Regards
> 
> Pedro Serrano
> 
> 
-- 
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK


