Return-Path: <SRS0=VgPO=WQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41789C3A589
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Aug 2019 10:32:34 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1629622CE3
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Aug 2019 10:32:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1629622CE3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35730 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i01RJ-00070q-70
	for qemu-devel@archiver.kernel.org; Tue, 20 Aug 2019 06:32:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45746)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1i01QH-0006MH-Pq
 for qemu-devel@nongnu.org; Tue, 20 Aug 2019 06:31:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1i01QG-0001rU-LN
 for qemu-devel@nongnu.org; Tue, 20 Aug 2019 06:31:29 -0400
Received: from mx1.redhat.com ([209.132.183.28]:47888)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1i01QG-0001r2-G3
 for qemu-devel@nongnu.org; Tue, 20 Aug 2019 06:31:28 -0400
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id A2CE611A3E
 for <qemu-devel@nongnu.org>; Tue, 20 Aug 2019 10:31:27 +0000 (UTC)
Received: by mail-wr1-f72.google.com with SMTP id i4so6799697wri.1
 for <qemu-devel@nongnu.org>; Tue, 20 Aug 2019 03:31:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=zRmCSsjiJXGe7+NQ2dvyO/kuzD5uZQw9bnQCimJQwPY=;
 b=EdMxyN7HUKAzmXK4QzoXyOdPPMJdmuQHZufuB84imViZ0ychd/E/9U/YdQz9IYFzpK
 aVmnEESzpqF1cy6ozH30iKniOKTJQEyJIqe4NMwCQz4Bhb7XvZ8DyBJkj6RCzkxtkMbx
 aVVVtaUyMJiGB9BB7LNHCe7rpQwPkrsu1oWpq/+X94ybB3+HzepUlff88I01diUj7jLK
 h9SiZd1XvS7VqyWzifk6XnUaihEbISqGHU964OO1po5YPV10O5XFklOMe5KcKcN94WoT
 Spq+uOuNADGc+ikF+ndb1gh63N/x6bSR1bUMcCTACe3rHre+zHbJWtXL1KNwT6DccSZX
 1I7A==
X-Gm-Message-State: APjAAAVNJLTQaoz6HUssvooGf4H2MQCFBsQVQl/eGj7UY9geoy5M07Ki
 Vxi8VNWWAtyGhINrdCmHMe/kD0yB+e+NeEldlOaGTaLPxIvHuh2zhK3ONqguvmOleK6B1b6ecdt
 KR1upWhMOlXV82j4=
X-Received: by 2002:adf:db03:: with SMTP id s3mr22460234wri.214.1566297085629; 
 Tue, 20 Aug 2019 03:31:25 -0700 (PDT)
X-Google-Smtp-Source: APXvYqxvxjDrwPtxBKCLEgDmnhOUrkDfLTedN3eLpT9179BdLCodg5hkXMLyYzHSIvWKGkhrXCzaBg==
X-Received: by 2002:adf:db03:: with SMTP id s3mr22460201wri.214.1566297085394; 
 Tue, 20 Aug 2019 03:31:25 -0700 (PDT)
Received: from [192.168.1.39] (251.red-88-10-102.dynamicip.rima-tde.net.
 [88.10.102.251])
 by smtp.gmail.com with ESMTPSA id r5sm16980865wmh.35.2019.08.20.03.31.24
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 20 Aug 2019 03:31:24 -0700 (PDT)
To: lampahome <pahome.chen@mirlab.org>,
 QEMU Developers <qemu-devel@nongnu.org>,
 "qemu-block@nongnu.org" <qemu-block@nongnu.org>
References: <CAB3eZfvki=jgCGvu5vNErGtW2gEDW9CXRsMR0LgNJLnNCWb9Ww@mail.gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Openpgp: id=89C1E78F601EE86C867495CBA2A3FD6EDEADC0DE;
 url=http://pgp.mit.edu/pks/lookup?op=get&search=0xA2A3FD6EDEADC0DE
Message-ID: <2cfc52ae-b8d8-387e-2290-8d42a4feba7c@redhat.com>
Date: Tue, 20 Aug 2019 12:31:23 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <CAB3eZfvki=jgCGvu5vNErGtW2gEDW9CXRsMR0LgNJLnNCWb9Ww@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] Difference between commit and rebase
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

Cc'ing qemu-block@

On 8/20/19 11:27 AM, lampahome wrote:
> I want to remove snapshots and I found two ways:
> qemu-img commit
> qemu-img rebase
> 
> I found they both can choose where to rebase(merge) the images.
> commit can truncate or not on specific image.
> rebase won't truncate rebased image.
> 
> I found they have something similarity and I don't know what situation is
> suitable for commit or rebase?

