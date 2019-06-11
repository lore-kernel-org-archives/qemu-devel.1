Return-Path: <SRS0=mXWu=UK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84165C4321A
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Jun 2019 14:17:18 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3B036205ED
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Jun 2019 14:17:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3B036205ED
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59404 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hahaP-0001ZL-9d
	for qemu-devel@archiver.kernel.org; Tue, 11 Jun 2019 10:17:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57584)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <pbonzini@redhat.com>) id 1hah5G-0001BK-OV
 for qemu-devel@nongnu.org; Tue, 11 Jun 2019 09:45:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <pbonzini@redhat.com>) id 1hah5F-0002yN-UQ
 for qemu-devel@nongnu.org; Tue, 11 Jun 2019 09:45:06 -0400
Received: from mail-wr1-f48.google.com ([209.85.221.48]:34427)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1hah5F-0002uT-Nx
 for qemu-devel@nongnu.org; Tue, 11 Jun 2019 09:45:05 -0400
Received: by mail-wr1-f48.google.com with SMTP id e16so13145775wrn.1
 for <qemu-devel@nongnu.org>; Tue, 11 Jun 2019 06:44:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=DBISPJOkBJwtMSNoFXYJdT/BAHxJqldrNty1sfmtXTo=;
 b=htQ+lcWpjoEyphahvOP4CRND/7T3qIJ/uHzThp44Kphp7ZMmj83n+bjLgDyKTmST7J
 5o3RKIqvjXd3l4gNHmBsARwIZhH44SBHk9pG8DLllCVDlROxXFffym2jrG4BRmltAbvt
 ++1jOBF5F+MuVJveut5wFVfXXC3w8VHtM7YqkXhctURAs+CjEZyRUliGqtYgsV7xhjs9
 3BVbfrsAeGNMp2Mj5hs3b3eRORJncQ2esj8pL0+GM2TXzYwFRauM+eYA1BTauyJUTlcM
 vPDDmmuqHdbvu2ZnROUDoaAVB7SaOGu72QsedWlWExRKhIw/YCO/cxZJMow4qbf+QBFJ
 CyhA==
X-Gm-Message-State: APjAAAVA5zlES0Z2A/f8hq+ZhwG0ONUC8snyVzIl0okJlqVYBFu6a8r8
 4yCiIx9TvXzM+Lhqs/BwO/KBwC7bdhf5cg==
X-Google-Smtp-Source: APXvYqz5W5EP0BAnpkQC8DWnwTj6q/xFbRJt7JgLsUcOUA0obUD048rahRQgoG3rgYzeypPXfRNizQ==
X-Received: by 2002:adf:9b8e:: with SMTP id d14mr1169778wrc.233.1560260692582; 
 Tue, 11 Jun 2019 06:44:52 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:49d3:a711:c5a3:8ebf?
 ([2001:b07:6468:f312:49d3:a711:c5a3:8ebf])
 by smtp.gmail.com with ESMTPSA id r2sm2902995wme.30.2019.06.11.06.44.51
 (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
 Tue, 11 Jun 2019 06:44:52 -0700 (PDT)
To: Markus Armbruster <armbru@redhat.com>
References: <5cf62de9.1c69fb81.66fc.8f4fSMTPIN_ADDED_BROKEN@mx.google.com>
 <1e9e4edd-f4ad-d8d6-95a2-e0aeab89510d@redhat.com>
 <5cf7b6e6.1c69fb81.1cdca.e260SMTPIN_ADDED_BROKEN@mx.google.com>
 <ec5033a4-5c68-91b7-ca9e-a1f38c990221@redhat.com>
 <003b01d51f72$5e6f4160$1b4dc420$@Fursova@ispras.ru>
 <67806828-f666-0c9c-00fc-b520f15013d9@suse.de>
 <e4fe4dc0-f3c4-a051-d39d-afd7bfdc680d@redhat.com>
 <98826c5f-4a74-5364-2aef-28a10db12c20@suse.de>
 <39250506-f38f-c440-5728-7b970d32ab41@redhat.com>
 <79b821a4-7cc0-2461-7ca4-d71c3e5ee4ef@suse.de>
 <c49abf01-c209-b206-edee-507c31269011@redhat.com>
 <87o934sdot.fsf@dusky.pond.sub.org>
 <8d391b41-bf6d-b83b-7b22-25fefa18c518@redhat.com>
 <87ftogp7f5.fsf@dusky.pond.sub.org>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <4ed45e59-6d7d-a9ea-9af3-7ec336c7ec3d@redhat.com>
Date: Tue, 11 Jun 2019 15:44:51 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <87ftogp7f5.fsf@dusky.pond.sub.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.85.221.48
Subject: Re: [Qemu-devel] qgraph
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
Cc: =?UTF-8?B?J9Cf0LDRiNCwJw==?= <Pavel.Dovgaluk@ispras.ru>,
 =?UTF-8?Q?Andreas_F=c3=a4rber?= <afaerber@suse.de>,
 Natalia Fursova <Natalia.Fursova@ispras.ru>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 11/06/19 15:39, Markus Armbruster wrote:
>> Right, and we should move more towards class-based properties so that
>> the dynamic nature of QOM is only used for the bare minimum needed (e.g.
>> memory regions).
> What are we doing to make new code conform to that?
> 
> What are we doing to update existing code?

Almost nothing and completely nothing. :(

Paolo

