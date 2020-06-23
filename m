Return-Path: <SRS0=Q9tF=AE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57273C433E0
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jun 2020 17:04:45 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 208C920774
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jun 2020 17:04:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="gkxFKjhK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 208C920774
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40664 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jnmLk-0002Sn-AT
	for qemu-devel@archiver.kernel.org; Tue, 23 Jun 2020 13:04:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54648)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1jnmKP-0001KO-J8
 for qemu-devel@nongnu.org; Tue, 23 Jun 2020 13:03:21 -0400
Received: from mail-wm1-x344.google.com ([2a00:1450:4864:20::344]:50632)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1jnmKN-0002iW-Rq
 for qemu-devel@nongnu.org; Tue, 23 Jun 2020 13:03:21 -0400
Received: by mail-wm1-x344.google.com with SMTP id l17so3661014wmj.0
 for <qemu-devel@nongnu.org>; Tue, 23 Jun 2020 10:03:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=references:user-agent:from:to:cc:subject:in-reply-to:date
 :message-id:mime-version:content-transfer-encoding;
 bh=tfYzqeONeL95lTYuJtTxc0aKu62ZhtgB0l2M/6sJwb4=;
 b=gkxFKjhKJ4y6+KBs0cMBET5SZMC7og0l5A5SaeVrgj3FzOjnPvAFq/QUKLoEuD5We6
 hUu7NP+wcBouYiyZGBc5Fuflw6urEuKNt5vFvOzviPBmbfchQISgC2sGaPukeIdr4S8C
 J8u4fhyTok87n7nnPHa6xA41XWMY8mlWo7HV+VGoa0SBlNcXRdFF0QfRqz0w3I6ZF/CF
 wwydqz2DGlDDcrX+AWcTofyJz65ypFGSbnpVWCOxUdAGaFBvPht+VEdu+CWCWcuBjxG+
 1XQkv/CkCxq+ElwcbzHcLifm1SlwL0dlFhYJPkq3yXhgheiY+4/06vYcGs+V3Pl8Zk36
 SXtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
 bh=tfYzqeONeL95lTYuJtTxc0aKu62ZhtgB0l2M/6sJwb4=;
 b=Ld2/5BqIk7vhJJuWNfyB7YMzmKHYJNFUsYRP6LmKrkuwiZmHlJ432rNU9aIL8ky+K2
 kaJxRJc5j+OVP5H67ve8MouwU9aWp5TlYbDz+4hVYnclUWMNfUhG7dORe+2y/53ql/SQ
 Kjw24H0I/eHKmMf8XEqe/ib+zbluPMXHrqTa0xEEm4bRARuBIMYqyq7qRUPylgtr0ikS
 V4cpdbyGdQY+mkSbx5/MEVb2q/8wFrG1kEdWdH842pKFPxq849CaVUzyZrvQho153GYW
 ylEGMPHkjnDe7ag7n8kZ4QyPqxXcW76jL2zPLYwoP5fT/Vr3EM5V1zRy1064LHP8n+XF
 kn+A==
X-Gm-Message-State: AOAM532LKjfJxoGlf03Zgrk5kC6l6UEtyW46LjnbWdmIMSWvORt1KSsR
 tUhuwzhfGSwPAGA1sLFrpfyURw==
X-Google-Smtp-Source: ABdhPJyvmB78FuCEH0lEEsg7k7dVTYifqlfTwZEkhYlWIzPrvCc5JNEaVQUUeKpIU71XlbhegR+pwg==
X-Received: by 2002:a1c:3286:: with SMTP id y128mr23923488wmy.29.1592931798034; 
 Tue, 23 Jun 2020 10:03:18 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id p4sm13026268wrx.63.2020.06.23.10.03.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 23 Jun 2020 10:03:16 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id D79F01FF7E;
 Tue, 23 Jun 2020 18:03:15 +0100 (BST)
References: <20200522023440.26261-1-richard.henderson@linaro.org>
 <20200522023440.26261-23-richard.henderson@linaro.org>
User-agent: mu4e 1.5.3; emacs 28.0.50
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Richard Henderson <richard.henderson@linaro.org>
Subject: Re: [PATCH v3 22/25] Standardize reginfo_dump_mismatch printing
In-reply-to: <20200522023440.26261-23-richard.henderson@linaro.org>
Date: Tue, 23 Jun 2020 18:03:15 +0100
Message-ID: <87y2od7m0c.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::344;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x344.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


Richard Henderson <richard.henderson@linaro.org> writes:

> Hoist the "master vs apprentice" label to apprentice(), since
> we will want different labels for dumping.  Remove all of the
> "mismatch" text from reginfo_dump_mismatch -- just print "vs".
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>

Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

--=20
Alex Benn=C3=A9e

