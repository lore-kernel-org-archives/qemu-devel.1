Return-Path: <SRS0=OzdF=4N=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22EB3C35DEA
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Feb 2020 01:14:16 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DF397218AC
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Feb 2020 01:14:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="knWfkBf5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DF397218AC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47054 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j6One-00078z-Vz
	for qemu-devel@archiver.kernel.org; Mon, 24 Feb 2020 20:14:15 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:37513)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <stefanrin@gmail.com>) id 1j6DVw-0000qj-Vn
 for qemu-devel@nongnu.org; Mon, 24 Feb 2020 08:11:14 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <stefanrin@gmail.com>) id 1j6DVw-0001Vs-5k
 for qemu-devel@nongnu.org; Mon, 24 Feb 2020 08:11:12 -0500
Received: from mail-il1-x12b.google.com ([2607:f8b0:4864:20::12b]:40963)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <stefanrin@gmail.com>)
 id 1j6DVu-0001V1-3U; Mon, 24 Feb 2020 08:11:10 -0500
Received: by mail-il1-x12b.google.com with SMTP id f10so7636373ils.8;
 Mon, 24 Feb 2020 05:11:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
 bh=xX58vDsOZ+wnHLXJge/ZyfPkNblZU0cLBO0NNGLhjiY=;
 b=knWfkBf55+2BUezscV0RObRaWDwuBoWuIxSAxiZZBkpGX+79EjbSbvPVv+VV5jUD4U
 KfWNlY0KprSCLjQliunv4FAFNxj+5f9swzf6Bx0gxPbpPUpb8Va99t3wAJjW2nYMFMyq
 sqdRKMrY+rGMdd+h2xeOJTH7LQz9uAMwuat1Yz1KeIsCDKboFtgLOsJBTNtmgnq/TRbm
 wxuPTTJVwNWnPHh/fMp2CjJzfruqeK/BnfOCIclcS6hcscXrW89P+MNJ0RgGwA29q8wp
 LqK9A+dp4hY6ORYD8NW3KDX9K4wA8vPpJncULOK2eWnvjN8X5y1tRkfFhTh2DUXsXPld
 6ajw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to;
 bh=xX58vDsOZ+wnHLXJge/ZyfPkNblZU0cLBO0NNGLhjiY=;
 b=fi5AP51AjNOgIATsuP/TWVWzG4aX30UZSBSuXU/w2hTY6gW2Ma8fWOWLGD/9qlPcOz
 DHcc6Y9LeKqytM9N46rjQQOVkIuJFZHURCjI0ysLzgb6OwYPC8aIBluIZzciaKDEMdc1
 LhwiF30sNE7TvqME7oP/BXX9tT52c1ds9J/+en2ILhRuU4uIIJl5zapHeFP3Xwy/HvyN
 HA9FwI4UXhVjix9cq4ULOoWXXLQL/Mujtt2zMQhlwdwQO/+2WSErbTJ6Vs9Wuz03NsNR
 0Oj0KkJKJ9RLulbDQ+DOs30WedJKy2rX2UAyQkcf8VpkBIdP4rNhP72kGZCZWUI/W6oZ
 mDiA==
X-Gm-Message-State: APjAAAVJ2Y9t2IS24tn7ZTUz83O5KZmq2A9knMkrGtqsWaKgDh4IOZPC
 z4LvbDdbbqG5ERsOO7+eU4tK+f8f8isrWB3BAYRR1DlZ
X-Google-Smtp-Source: APXvYqzdqQAzMXNXJ4dO80EdJr99Tp4h5c0j8n2IcoPOF/lBp2J8b/4ll712iUdxsPX+V2b+cYzH1ZyWRCb4v339J7M=
X-Received: by 2002:a92:8311:: with SMTP id f17mr60707362ild.82.1582549868614; 
 Mon, 24 Feb 2020 05:11:08 -0800 (PST)
MIME-Version: 1.0
References: <CAAxjCEzHQz4cG_8m7S6=CwCBoN5daQs+KVyuU5GL5Tq3Bky1NA@mail.gmail.com>
 <CAAxjCEx79Fkjw9tFbSMo+b1LGv2LNivLRXf1GS9JsYnXrNVVkQ@mail.gmail.com>
In-Reply-To: <CAAxjCEx79Fkjw9tFbSMo+b1LGv2LNivLRXf1GS9JsYnXrNVVkQ@mail.gmail.com>
From: Stefan Ring <stefanrin@gmail.com>
Date: Mon, 24 Feb 2020 14:10:57 +0100
Message-ID: <CAAxjCEwF440kbrqRAsKWVic9WNS7a5tCopksrH6bSg7Hr9jimw@mail.gmail.com>
Subject: Re: Strange data corruption issue with gluster (libgfapi) and ZFS
To: qemu-block@nongnu.org, qemu-devel@nongnu.org, integration@gluster.org
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::12b
X-Mailman-Approved-At: Mon, 24 Feb 2020 20:12:27 -0500
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

On Mon, Feb 24, 2020 at 1:35 PM Stefan Ring <stefanrin@gmail.com> wrote:
>
> [...]. As already stated in
> the original post, the problem only occurs with multiple parallel
> write requests happening.

Actually I did not state that. Anyway, the corruption does not happen
when I restrict the ZFS io scheduler to only 1 request at a time
(zfs_vdev_max_active), therefore I assume that this is somehow related
to the ordering of asynchronously scheduled writes.

