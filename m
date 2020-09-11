Return-Path: <SRS0=/zFi=CU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84B70C43461
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Sep 2020 11:29:10 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9A2CB221EB
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Sep 2020 11:29:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JuqtOePD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9A2CB221EB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36896 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kGhEq-0007Hl-CK
	for qemu-devel@archiver.kernel.org; Fri, 11 Sep 2020 07:29:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46528)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kGhE4-0006rL-Ix
 for qemu-devel@nongnu.org; Fri, 11 Sep 2020 07:28:20 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:24357)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kGhE2-0000Sm-7y
 for qemu-devel@nongnu.org; Fri, 11 Sep 2020 07:28:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1599823696;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=55TU6qw1iwnavZl+BlEVEM7tLgb7CKwjgdz+xa5nXI8=;
 b=JuqtOePDC/VNnNQt3+B8j+ARvB7Vx01g9NXOwDmhBU5pJdsgbuQhx6sp73h46jiq9aD5Ee
 9SXZGnES1doYZ8YlZbfhM9TMctgIPc0lqZJZtFmkpB4QHeMts3akbcFPZ/D0srrJruqIZ4
 QuL9dGKOeZN/AGH3yllMwGsWPbGEDa4=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-121-YDWrOdX3M3aul4bUkpZQhA-1; Fri, 11 Sep 2020 07:28:15 -0400
X-MC-Unique: YDWrOdX3M3aul4bUkpZQhA-1
Received: by mail-ej1-f72.google.com with SMTP id rs9so4409181ejb.17
 for <qemu-devel@nongnu.org>; Fri, 11 Sep 2020 04:28:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=55TU6qw1iwnavZl+BlEVEM7tLgb7CKwjgdz+xa5nXI8=;
 b=n0YhtVpBWBEuiD6GhMapvlUK3UeXUsNz3KCxDD7TOnv9wnW0LGx8o8gbZxZWtycxsH
 +Ukc+iAUWnlkr/oKBfP+JOQ+sYfq+uo1MTlHKmv9X2O+/MvdOys7ffseTOUfHeLgN5b2
 V7ffmCNbn0/J4tH0gWvIwyKYoomzk8BrfpyXPCc7L116nqXYmZ8euCKb7Iv4OIQQ11k8
 4y0cz2ANpVXvb4kBQsMUQIfWdoXwI79tLih76LWoVJYQdHUPbCmhO2j4qvcYDsrQrnIT
 CbLQ4R4wXPE25YX+tzXRqBp8ovXdw9MdmcUO3bLGsrpaYuH7+roRy0gc60GCTNWOw1QI
 WCAQ==
X-Gm-Message-State: AOAM533zdWRBM2SuAcffAkPBy5ttKdsap/XrJrzZHZI7hoi4Nka80i8O
 dIt0l1qBI0/61fhFsekQCKWY8/+0DocdXonXdIe7qGJz/3Q38Kra6xYKd3IVKTCMjVqMypG3K5q
 CPntU6LUOuJbiPec=
X-Received: by 2002:a17:906:8143:: with SMTP id
 z3mr1528438ejw.323.1599823693899; 
 Fri, 11 Sep 2020 04:28:13 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzntfovWpUifC/XK2pKBn9ITVQnvZ7I5Mf2QZHNGQ5e6a5Ha+b/xyfOVHfrYOTbFNPtnlrE2w==
X-Received: by 2002:a17:906:8143:: with SMTP id
 z3mr1528419ejw.323.1599823693719; 
 Fri, 11 Sep 2020 04:28:13 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:5568:7f99:4893:a5b6?
 ([2001:b07:6468:f312:5568:7f99:4893:a5b6])
 by smtp.gmail.com with ESMTPSA id s15sm1355565eju.105.2020.09.11.04.28.12
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 11 Sep 2020 04:28:13 -0700 (PDT)
Subject: Re: [PATCH] PoC: Rust binding for QAPI (qemu-ga only, for now)
To: =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>,
 marcandre.lureau@redhat.com
References: <20200910174850.716104-1-marcandre.lureau@redhat.com>
 <20200911104642.GE1203593@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <6599e4a5-cccb-d0f5-9408-25d59359d76f@redhat.com>
Date: Fri, 11 Sep 2020 13:28:13 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <20200911104642.GE1203593@redhat.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=pbonzini@redhat.com
X-Mimecast-Spam-Score: 0.001
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Received-SPF: pass client-ip=216.205.24.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/10 23:26:59
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -45
X-Spam_score: -4.6
X-Spam_bar: ----
X-Spam_report: (-4.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-2.469, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
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
Cc: stefanha@gmail.com, jsnow@redhat.com, qemu-devel@nongnu.org, slp@redhat.com,
 armbru@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 11/09/20 12:46, Daniel P. Berrangé wrote:
> Do we actually need/want it to be in the same monolithic repo
> as qemu, as opposed to a qemu-qapi-rust repo ?

I think QAPI and qemu-ga should be separate repos altogether.  QAPI
should be included as a submodule in both qemu and qemu-ga.  qemu-ga
instead has absolutely no dependency on QEMU and viceversa, and is a
prime candidate for removing all traces of the configure script and
being a pure meson project.

Paolo


