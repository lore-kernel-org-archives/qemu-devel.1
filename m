Return-Path: <SRS0=cfdO=BG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8E58C433DF
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Jul 2020 14:46:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9DB2520719
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Jul 2020 14:46:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RpNVVIqX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9DB2520719
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47554 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k04O7-00050p-TT
	for qemu-devel@archiver.kernel.org; Mon, 27 Jul 2020 10:45:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55274)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nsoffer@redhat.com>)
 id 1k04NL-0004B2-OY
 for qemu-devel@nongnu.org; Mon, 27 Jul 2020 10:45:11 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:40665
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <nsoffer@redhat.com>)
 id 1k04Mr-0002m5-Ts
 for qemu-devel@nongnu.org; Mon, 27 Jul 2020 10:45:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1595861081;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=dCixgj7iuJI6XYXm3gFJhDO7N49x13iB0GYRcd/fcKU=;
 b=RpNVVIqXfUtnrm+bQffWGE18IwH5QZMJUFDmAFbp+NHEgEhyjvUtP2uePvtX5TCJ7rut8Y
 q9OLbYrpWeE956jNFJDTDzWXV4psUbVZPEOUVv478thHGJrvhaC/L8ok+4fyUiTd9Av2qC
 nTqXzxa2JXAsrryHlqHC0VVWnnIV3F0=
Received: from mail-oi1-f197.google.com (mail-oi1-f197.google.com
 [209.85.167.197]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-424-XnArmHmxOIK4SGrVXTH5EQ-1; Mon, 27 Jul 2020 10:44:39 -0400
X-MC-Unique: XnArmHmxOIK4SGrVXTH5EQ-1
Received: by mail-oi1-f197.google.com with SMTP id a13so2353300oie.4
 for <qemu-devel@nongnu.org>; Mon, 27 Jul 2020 07:44:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=dCixgj7iuJI6XYXm3gFJhDO7N49x13iB0GYRcd/fcKU=;
 b=UpE7SrbXmMJvjlZP9MsuBCOxgWgYW+TegCcy4pvdEA8JqRnDvK2iD4ktI6Y2WMKRMz
 pHrbpKZUWOZDF5Mg5PiDlx+pCscXkhBo5NK54ZvSOgK4cxkdSg37jp4+aNie0z55X3m+
 +IAJ6Z1ENFtkQEBVVKGOsg6yZLT0v/6t3AJoN3nESrsZxHnc4qTyYzi9grBHTC/qWmRY
 C3UJZ6O705xALPCrFYxWfUWNIFAwDdwnlWo0yzRuvyCRSqqjA5YZIrwtum+1zq7N+fP9
 md/xNpLVCbOFVr9JuVIgkHzs7/eGLN6q1mjZZz5GO/qUnFv8n6ZTmSXjgwI4HW4CNIbV
 eiuQ==
X-Gm-Message-State: AOAM53085Pco0xoB4ehW98a+gySdaYWjjINGbi8aLKIQaj46/3iv7VQy
 XvvWmxO8VWXSzmAWTz91hH2nP6SNufEL7u+oFFlBG4i3A4pPN23KIp+/rIic3XZVf1T4sek5YNp
 CeEml1zFIc+TqB68XVXBFN6GechorGp4=
X-Received: by 2002:aca:5b05:: with SMTP id p5mr7633461oib.156.1595861078525; 
 Mon, 27 Jul 2020 07:44:38 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwflruGpmKBzp/QMHpF6ATTVQkR1Ht4uSuD7Ye86QOMjeYvKQ7chLlUU0fE00sI3b6Us0NhX54IECWFE4Qgnhg=
X-Received: by 2002:aca:5b05:: with SMTP id p5mr7633437oib.156.1595861078255; 
 Mon, 27 Jul 2020 07:44:38 -0700 (PDT)
MIME-Version: 1.0
References: <20200726152532.256261-1-nsoffer@redhat.com>
 <20200726152532.256261-3-nsoffer@redhat.com>
 <b0e61f48-d272-0aa5-3698-5d17a1de0774@redhat.com>
 <b4c0408f-da30-259f-b175-15e709ee987c@redhat.com>
 <CAMRbyytButqSyqAXVFgMzMKoaRUYfCYWAUAoFQs9TXS0PSrX0Q@mail.gmail.com>
 <5e87add3-57ed-1c57-4ea3-07a77cda3882@redhat.com>
In-Reply-To: <5e87add3-57ed-1c57-4ea3-07a77cda3882@redhat.com>
From: Nir Soffer <nsoffer@redhat.com>
Date: Mon, 27 Jul 2020 17:44:22 +0300
Message-ID: <CAMRbyyvDMnPkUNPUbzVTPYp3LB=unkBCRVn=zjT=AtMFSh1PJw@mail.gmail.com>
Subject: Re: [PATCH 2/2] qemu-iotests: Test convert to qcow2 compressed to NBD
To: Eric Blake <eblake@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=205.139.110.61; envelope-from=nsoffer@redhat.com;
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
Cc: QEMU Developers <qemu-devel@nongnu.org>, Kevin Wolf <kwolf@redhat.com>,
 qemu-block <qemu-block@nongnu.org>, Nir Soffer <nirsof@gmail.com>,
 Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, Jul 27, 2020 at 5:41 PM Eric Blake <eblake@redhat.com> wrote:
>
> On 7/27/20 9:35 AM, Nir Soffer wrote:
>
> >> I guess it's okay that you don't create a real tar file here, but
> >> listing the commands to create it (even as a comment) is better than
> >> just saying "trust me".  And it doesn't seem like that much more work -
> >> it looks like the key to your test is that you created a tar file
> >> containing two files, where the first file was less than 512 bytes and
> >> the second file is your target destination that you will be rewriting.
> >
> > The real code is more complicated, something like:
> >
> >      offset = tar.fileobj.tell() + BLOCK_SIZE
> >
> >      with open(tar.name, "r+") as f:
> >          f.truncate(offset + measure["required"])
> >
> >      convert_image(image, tar.name, offset)
> >
> >      check = check_image(tar.name, offset)
> >      size = check["image-end-offset"]
> >
> >      member = tarfile.TarInfo(name)
> >      member.size = size
> >      tar.addfile(member)
> >
> >      tar_size = offset + round_up(size)
> >
> >      tar.fileobj.seek(tar_size)
> >      with open(tar.name, "r+") as f:
> >          f.truncate(tar_size)
> >
> > I'm not sure it helps qemu developers working on these tests.
>
> The closer the iotest is to reality, the more likely it will serve as a
> good regression test.  Cutting corners risks a test that passes in
> isolation even when we've done something that breaks the overall process
> in one of the corners you cut.

I'll add this code then.

> >>
> >> At any rate, given the urgency of getting pull requests for -rc2 in
> >> before slamming Peter tomorrow, I'll probably try to touch up the issues
> >> Max pointed out and queue it today.
> >
> > Thanks Max and Eric.
> >
> > Should I post a fixed version later today?
>
> A v2 would be helpful.

Will post later today.


