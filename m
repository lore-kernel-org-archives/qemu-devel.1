Return-Path: <SRS0=aoXf=X5=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E8F4C4360C
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Oct 2019 16:42:40 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 428EC20873
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Oct 2019 16:42:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 428EC20873
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50566 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iGQf9-0002IN-Cs
	for qemu-devel@archiver.kernel.org; Fri, 04 Oct 2019 12:42:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49325)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <pbonzini@redhat.com>) id 1iGQeJ-0001ez-Ng
 for qemu-devel@nongnu.org; Fri, 04 Oct 2019 12:41:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <pbonzini@redhat.com>) id 1iGQeH-0004d1-Kd
 for qemu-devel@nongnu.org; Fri, 04 Oct 2019 12:41:46 -0400
Received: from mx1.redhat.com ([209.132.183.28]:39810)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1iGQeH-0004ZB-FD
 for qemu-devel@nongnu.org; Fri, 04 Oct 2019 12:41:45 -0400
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 7ACB08E58C
 for <qemu-devel@nongnu.org>; Fri,  4 Oct 2019 16:41:44 +0000 (UTC)
Received: by mail-wr1-f69.google.com with SMTP id n3so2982571wrt.9
 for <qemu-devel@nongnu.org>; Fri, 04 Oct 2019 09:41:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=XT3Ya3N4um8Pq0veFKNMJl0r2mpnF4FTAEmB6RtqXtU=;
 b=RSOKZJM/Z2lpyuYkt09z0e6ZfEsy7ck34hSHX5uN+Pd/QZv5tf7s4jlyGkNrVoOVJQ
 QSMYLsUnf/+ke8oq/y85rs/b1BbBKVX/bX8ZC9Jn5waLZS0rix/11zrX6iwuzXWwPsLf
 1NYMaRb5/uxr+T2Ap3PZRTBMfnl6pFhg+qSuHDhsUV0j6bd8cEvtKQLhLU72JkIiwghE
 ufiXkuRH5p2HZllvpF9J4Pxd9Is2MltcXF78l+CTdymqW6vSx2XX3KLGlKHbQqHNv9AK
 IBrRODAu8rLkIrpXJeOLk3BMt1Sv8vMpjVHobBkD/k52R5CsZ7ZJ9bh5oELFbzSeD+Z9
 h9vA==
X-Gm-Message-State: APjAAAXqCEsnLmBHbBTI0WuYiBiGDesIo2xgQMGuJh//ZqpEfd+pxbQx
 g6fw7aq/ovWgW/3lZ8GDhFB7KWfo6JNDDwcN3YbPG0JXyrKxxnutNUUwptUHoAYutDFXiibOfz2
 OEFBX/a1A5yft25A=
X-Received: by 2002:a5d:4043:: with SMTP id w3mr13013672wrp.318.1570207303149; 
 Fri, 04 Oct 2019 09:41:43 -0700 (PDT)
X-Google-Smtp-Source: APXvYqzJj1K/nvpkdRDAjVU/PdWGdx9RgVWycMbPtZDiEx4HIRFIKxtJEO+WTPzwVP72yKoXOX0Zeg==
X-Received: by 2002:a5d:4043:: with SMTP id w3mr13013658wrp.318.1570207302853; 
 Fri, 04 Oct 2019 09:41:42 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:9dd9:ce92:89b5:d1f2?
 ([2001:b07:6468:f312:9dd9:ce92:89b5:d1f2])
 by smtp.gmail.com with ESMTPSA id b12sm6726402wrt.21.2019.10.04.09.41.41
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 04 Oct 2019 09:41:42 -0700 (PDT)
Subject: Re: libvirt? qemu change that mmaps ELF files breaks libvirt svirt
 handling for os.kernel
To: Christian Borntraeger <borntraeger@de.ibm.com>,
 =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>
References: <d450afbe-06ae-f6f7-3bc0-f1a54c31907c@de.ibm.com>
 <1dc0a320-b771-072d-d1f4-4eda2ab51a1f@redhat.com>
 <a12ee0e1-44cc-e197-68e3-4a7137c8b972@de.ibm.com>
 <20191004123613.GF25716@redhat.com>
 <b44c70b1-71b6-2249-d50a-9a9e02f79259@de.ibm.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Openpgp: preference=signencrypt
Message-ID: <f5bb2615-17cc-eedd-124d-8cec1eff979b@redhat.com>
Date: Fri, 4 Oct 2019 18:41:41 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <b44c70b1-71b6-2249-d50a-9a9e02f79259@de.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.132.183.28
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
Cc: Libvirt <libvir-list@redhat.com>, Claudio Imbrenda <imbrenda@linux.ibm.com>,
 Marc Hartmayer <mhartmay@linux.ibm.com>, qemu-devel <qemu-devel@nongnu.org>,
 Stefano Garzarella <sgarzare@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 04/10/19 14:47, Christian Borntraeger wrote:
>> Please file a bz entry against the selinux-policy component for
>> whatever distro you're using, and/or Fedora rawhide, and CC me
>> on it too.
> 
> Done. This was on Fedora 30.
> https://bugzilla.redhat.com/show_bug.cgi?id=1758525
> 
>  Now sure about others like RHEL. RHV.
> 

We'll take care of that.  Thanks!

Paolo

