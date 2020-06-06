Return-Path: <SRS0=faK4=7T=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0CA8AC433DF
	for <qemu-devel@archiver.kernel.org>; Sat,  6 Jun 2020 19:10:40 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C93B020723
	for <qemu-devel@archiver.kernel.org>; Sat,  6 Jun 2020 19:10:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="bvwHQVZC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C93B020723
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46698 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jheDH-0005zJ-3r
	for qemu-devel@archiver.kernel.org; Sat, 06 Jun 2020 15:10:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36978)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jheBV-0004aP-0U
 for qemu-devel@nongnu.org; Sat, 06 Jun 2020 15:08:49 -0400
Received: from mail-pj1-x1044.google.com ([2607:f8b0:4864:20::1044]:35645)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jheBU-0002n9-7s
 for qemu-devel@nongnu.org; Sat, 06 Jun 2020 15:08:48 -0400
Received: by mail-pj1-x1044.google.com with SMTP id i4so202932pjd.0
 for <qemu-devel@nongnu.org>; Sat, 06 Jun 2020 12:08:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:references:from:message-id:date:user-agent:mime-version
 :in-reply-to:content-language:content-transfer-encoding;
 bh=YUi5Fu356XrkGVFLXEgMKb+vOZ8LKqGWoDX7rRIBwsw=;
 b=bvwHQVZCEOgzICZvb5wfq90Y1Nss62oiZzjiG0LELzoR3Oukfdmq1Vfp2BIRkJFXPR
 7NVHdrxiL7BJhLHx/Ux+SAxuEf6FzMQS0CcApKpdhNUU41rvrQvdQAWCRVZtXQpanteY
 H8CyD6BPG1kJeFAh4vZRzLBsBs1+hC+achZq0zVn988vuiqH+a7u1SSz0VnKhX3Nph1B
 XX+A3GL7gvSEKRgOHw65KU36HbWk/njLJdbsS3+A/PW21tWkKxXJvEiYjcIOCNbRsjqn
 gqNC5Iv0Yf9HUvpmltq7Ef5k0B0jtibmMIwEGydgw+S+8IrebcXq7DKSvrKXZAvxA9iK
 Lu2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=YUi5Fu356XrkGVFLXEgMKb+vOZ8LKqGWoDX7rRIBwsw=;
 b=dufJ9mYCD1H02w+1yYXGVWiDmXYNkBY5QPkhPI5vH+fTGN70/468wKfI9ueHHRDYHf
 EOFdZseS+tO6lUSi9ko18S/gEZOIbfeup6w9GSrOXK7AF5kNrsaTrubB9Lm3BHEutGbF
 s57rQzA9RYhH/b0GrPXmHZST7eive1P6kF8BSeRV24LWKD5jsoxTysD8EUmqZIoOthsM
 ahetJQJ7H2AkWeO0ArjOn9m91f5ElOhHk0rpxMS2m8sFHc73NzbqV2+ozE+w9QaLXYuZ
 pb0+cXTnDwWOLSzldUHB5110666p79Nz58gpmLB1O40RTc/8g7O2VQWjTNcyQT+nKcGQ
 FyuQ==
X-Gm-Message-State: AOAM5314pjut6tripgl/vpi91tTh86rOvUvctJTYXO/XmpuSdK+J61QV
 pCn/HcZPW80S59A/lnZmLY10E9e5j4Q=
X-Google-Smtp-Source: ABdhPJzsDlv4GuMTGzTUX3fUEOVvKMAXrFyB48ph4WaeT8Ij0hKa28LjyH+2iWxFSIespvxx7L6GVQ==
X-Received: by 2002:a17:902:6947:: with SMTP id
 k7mr14939563plt.258.1591470526830; 
 Sat, 06 Jun 2020 12:08:46 -0700 (PDT)
Received: from [192.168.1.11] (174-21-143-238.tukw.qwest.net. [174.21.143.238])
 by smtp.gmail.com with ESMTPSA id c1sm2942775pfo.197.2020.06.06.12.08.45
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 06 Jun 2020 12:08:46 -0700 (PDT)
Subject: Re: [PATCH 4/7] softfloat: do not set denominator high bit for
 floatx80 remainder
To: Joseph Myers <joseph@codesourcery.com>, qemu-devel@nongnu.org,
 aurelien@aurel32.net, peter.maydell@linaro.org, alex.bennee@linaro.org,
 laurent@vivier.eu, pbonzini@redhat.com, rth@twiddle.net, ehabkost@redhat.com
References: <alpine.DEB.2.21.2006051857110.13777@digraph.polyomino.org.uk>
 <alpine.DEB.2.21.2006051900410.13777@digraph.polyomino.org.uk>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <5efb2fa2-8837-4420-b4e5-ffee76ce843d@linaro.org>
Date: Sat, 6 Jun 2020 12:08:44 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.21.2006051900410.13777@digraph.polyomino.org.uk>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1044;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1044.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 6/5/20 12:01 PM, Joseph Myers wrote:
> The floatx80 remainder implementation unnecessarily sets the high bit
> of bSig explicitly.  By that point in the function, arguments that are
> invalid, zero, infinity or NaN have already been handled and
> subnormals have been through normalizeFloatx80Subnormal, so the high
> bit will already be set.  Remove the unnecessary code.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~

