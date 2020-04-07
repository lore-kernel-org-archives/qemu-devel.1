Return-Path: <SRS0=U3m5=5X=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5168C2D0EC
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Apr 2020 19:14:02 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 86F6320748
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Apr 2020 19:14:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gQuSH0pI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 86F6320748
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52236 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jLtfd-00057D-Kk
	for qemu-devel@archiver.kernel.org; Tue, 07 Apr 2020 15:14:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46385)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <timhaley2112@gmail.com>) id 1jLtf7-0004gY-7c
 for qemu-devel@nongnu.org; Tue, 07 Apr 2020 15:13:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <timhaley2112@gmail.com>) id 1jLtf6-0003Xh-8u
 for qemu-devel@nongnu.org; Tue, 07 Apr 2020 15:13:29 -0400
Received: from mail-io1-xd29.google.com ([2607:f8b0:4864:20::d29]:37128)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <timhaley2112@gmail.com>)
 id 1jLtf6-0003XR-1v
 for qemu-devel@nongnu.org; Tue, 07 Apr 2020 15:13:28 -0400
Received: by mail-io1-xd29.google.com with SMTP id n20so4592111ioa.4
 for <qemu-devel@nongnu.org>; Tue, 07 Apr 2020 12:13:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=to:from:subject:message-id:date:user-agent:mime-version
 :content-language:content-transfer-encoding;
 bh=rDVXs0WUFzDtHK+tkxDSLXWbmy+Ljv2o2tI+yry7hpc=;
 b=gQuSH0pIoOqV3l3lMSg7PoX0wvbVnlzNSCOBLhCfsbhyzCWrrAnW1WbgKj3pJbK+qt
 l/P29VGkXD+BrMy5NyrHft7650nzWNo6T1fkJY8DeT/q8kx9T5BL1VywDBviM/RBxKPB
 euLHzRFnh416wfHctyboJGmHnnxUK0U16UwwReU9FuRWF+xLAUQ+MTh9h8q6J8WvrEqZ
 eyJyWYnw+IdwHfaydaoi+0Zf/tw6DhdDnfAb9WWBXiDa7xC5ANubQfoqSKgQXMri38Sp
 NVdLGceSBRUelDx1TBvo6WThlIwP5WUSN0eH068eOU0bYNm4NtUaZ5PDqLig6PkblSIw
 0amQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:to:from:subject:message-id:date:user-agent
 :mime-version:content-language:content-transfer-encoding;
 bh=rDVXs0WUFzDtHK+tkxDSLXWbmy+Ljv2o2tI+yry7hpc=;
 b=LbCFHdGvd5NY/CqwAj8dmuPgLOC0jiR8cLbu9kIl5o0GQ2xQeVUrDO8xefXIqzB9BI
 VXbrllsrmCcVhlH23orHAke49o+75p4ebLPluuq8mSp0OBqElZCtsw60XdtBc6kYq2Me
 u1kagfqvAPzV9sAhXMO06UX3OIpYp9L+0THNdxGv06tNpp6tIZ5AN2OLDG3232ITqnyt
 oMHMV9UjfryanhbZ2UX4/KxHQ+8miXNDNAm1TPHSDRcZ3/SZ899HOrF4R5qd/eBvTVqc
 foCV5RSWoODrb4l5p/g6aH6U7h+K4CflpmmNiJ8jRo42xPlXuOVC3o4yanfMDli6OGwE
 aNHg==
X-Gm-Message-State: AGi0PuYVGMGEs9vMDnfmwAx+Hvnd8YvoTzRQEkq5gfNd6SWCB35KclsO
 sckDuqj4kl1TqPUq/pgJYvKzyzJw
X-Google-Smtp-Source: APiQypLNMuoirZcGLxzpQTBe4jsCE7ghxsWojCEryjKDw1OYSGOiCsAJpAgWTQfuqS8wTG5b5Zfylg==
X-Received: by 2002:a6b:dd0b:: with SMTP id f11mr3641864ioc.70.1586286806810; 
 Tue, 07 Apr 2020 12:13:26 -0700 (PDT)
Received: from Tims-MacBook-Pro.local (71-33-221-154.hlrn.qwest.net.
 [71.33.221.154])
 by smtp.gmail.com with ESMTPSA id v17sm7348828ilq.49.2020.04.07.12.13.26
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 07 Apr 2020 12:13:26 -0700 (PDT)
To: qemu-devel@nongnu.org
From: Tim Haley <timhaley2112@gmail.com>
Subject: Domain backup file explodes on s3fs
Message-ID: <0d78c593-7b5d-5f73-ea05-e81d9bc35373@gmail.com>
Date: Tue, 7 Apr 2020 13:13:25 -0600
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:68.0)
 Gecko/20100101 Thunderbird/68.6.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::d29
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

Hi all,

Have been playing with `virsh backup-begin` of late and think it's an 
excellent feature. I've noticed one behavior I'm not sure I understand. 
Am doing pretty straight-forward backup of boot disk:

# cat bx
<domainbackup>
   <disks>
     <disk name='vda' type='file'>
     <target file='/backups/vda.2aa450cc-6d2e-11ea-8de0-52542e0d008a'/>
       <driver type='qcow2'/>
     </disk>
   </disks>
</domainbackup>

# cat cx
<domaincheckpoint>
   <name>2aa450cc-6d2e-11ea-8de0-52542e0d008a</name>
   <disks>
     <disk name='vda' checkpoint='bitmap'/>
   </disks>
</domaincheckpoint>

# virsh backup-begin 721 bx cx

If my /backups directory is just XFS, I get a backup file that looks 
like it is just the size of data blocks in use

-rw------- 1 root  root  2769551360 Mar 19 16:56 
vda.2aa450cc-6d2e-11ea-8de0-52542e0d008a

but if I write to an s3fs (object storage backend) the file blows up to 
the whole size of the disk

-rw------- 1 root  root  8591507456 Mar 18 19:03 
vda.2aa450cc-6d2e-11ea-8de0-52542e0d008a

Is this expected?

If it's relevant, this is on ubuntu and
# virsh version
Compiled against library: libvirt 6.1.0
Using library: libvirt 6.1.0
Using API: QEMU 6.1.0
Running hypervisor: QEMU 4.2.0

thanks for any ideas,
-tim




