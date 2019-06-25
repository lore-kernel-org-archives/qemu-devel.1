Return-Path: <SRS0=PhvJ=UY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC7DCC48BD4
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Jun 2019 16:12:16 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 855602080C
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Jun 2019 16:12:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 855602080C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33570 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hfo3L-0000m0-Qu
	for qemu-devel@archiver.kernel.org; Tue, 25 Jun 2019 12:12:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39893)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <philmd@redhat.com>) id 1hfnrN-0001VM-Kd
 for qemu-devel@nongnu.org; Tue, 25 Jun 2019 11:59:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1hfnrM-0001Il-8N
 for qemu-devel@nongnu.org; Tue, 25 Jun 2019 11:59:53 -0400
Received: from mail-wr1-f49.google.com ([209.85.221.49]:33536)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1hfnrM-0001Fk-0Y
 for qemu-devel@nongnu.org; Tue, 25 Jun 2019 11:59:52 -0400
Received: by mail-wr1-f49.google.com with SMTP id n9so18554486wru.0
 for <qemu-devel@nongnu.org>; Tue, 25 Jun 2019 08:59:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=tVjy3sT0Ln7b7cAJDQXWIqcF14h5V/SJTWYUlX3aobw=;
 b=lIGUQjTALQHYUfvacrN5nJWbZiDIP/EgUt7PqwHTRYDQJABXBEooBi5QYrHTqVp55O
 JoxnDkG2TawgiTDKV9ExkKuwj82RACb+38qIoEubAF8/tSW1mULZ2JN8y+iVj/NFT1ty
 IQ2NNsHgZEBD/LMaQ5K8oNYQ+/rJoQirAjB9/y2ccOyc6Le146b5c9vDtc4VGz3GcvBG
 4PaEs0cSHE61ttXboGp84ojLs/NZcmc0A1wQ9sfsuI0aPGRlvMZGNI0Jj9kTUeR17fRr
 Bw97/ZrB1teNqfZ6eg9dzvQwnvCSxHQj+aYptRjX7HxcAzLaOwUG1nC5/xkhFCLSRGNb
 SdbA==
X-Gm-Message-State: APjAAAX0589+lAdWq5DzOUI6Nu6aOECR27+YiUzUCPrSsSzhEh3xRzwe
 86DmDq434GQZQ5RoN5mbaVYSNjDotX4=
X-Google-Smtp-Source: APXvYqyW7DSmUmRqIHZyGNQx02WENRk128zpKj4wjQnFrTqA8mMXvvVU1PQ1AvkanbDR03p5eMA+kw==
X-Received: by 2002:adf:82e2:: with SMTP id 89mr24361636wrc.33.1561478388229; 
 Tue, 25 Jun 2019 08:59:48 -0700 (PDT)
Received: from [192.168.1.38] (183.red-88-21-202.staticip.rima-tde.net.
 [88.21.202.183])
 by smtp.gmail.com with ESMTPSA id s9sm2240162wmc.11.2019.06.25.08.59.47
 (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
 Tue, 25 Jun 2019 08:59:47 -0700 (PDT)
To: Laurent Vivier <laurent@vivier.eu>,
 Bug 1833668 <1833668@bugs.launchpad.net>, qemu-devel@nongnu.org
References: <156110323981.19354.11667763271761846721.malonedeb@wampee.canonical.com>
 <156147381286.18147.1572558561573422063.malone@gac.canonical.com>
 <d5c913aa-0edf-ff4b-f21e-8c1a375e10fd@vivier.eu>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Openpgp: id=89C1E78F601EE86C867495CBA2A3FD6EDEADC0DE;
 url=http://pgp.mit.edu/pks/lookup?op=get&search=0xA2A3FD6EDEADC0DE
Message-ID: <43eac243-bfb9-fc66-d0ce-8135c68e14a4@redhat.com>
Date: Tue, 25 Jun 2019 17:59:47 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <d5c913aa-0edf-ff4b-f21e-8c1a375e10fd@vivier.eu>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.85.221.49
Subject: Re: [Qemu-devel] [Bug 1833668] Re: linux-user: Unable to run ARM
 binaries on Aarch64
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

On 6/25/19 5:27 PM, Laurent Vivier wrote:
> Le 25/06/2019 à 16:43, Richard Henderson a écrit :
>> Of course.  There's a separate qemu-arm executable for that.
> 
> On some other architectures (like ppc/ppc64) the idea is the 64bit
> version supports also all 32bit versions CPUs.
> 
> I think it's why this bug has been opened.

At any rate the error message could be more explicit, to avoid confusion.

