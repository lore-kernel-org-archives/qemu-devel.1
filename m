Return-Path: <SRS0=UEgn=BO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41305C433E1
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Aug 2020 16:16:43 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1C29B2086A
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Aug 2020 16:16:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="IoY20AyP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1C29B2086A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54228 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k2zcI-0003Qa-Ai
	for qemu-devel@archiver.kernel.org; Tue, 04 Aug 2020 12:16:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46948)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1k2zam-0001rQ-M0
 for qemu-devel@nongnu.org; Tue, 04 Aug 2020 12:15:08 -0400
Received: from mail-wm1-x342.google.com ([2a00:1450:4864:20::342]:40597)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1k2zak-0006pK-Dq
 for qemu-devel@nongnu.org; Tue, 04 Aug 2020 12:15:08 -0400
Received: by mail-wm1-x342.google.com with SMTP id k20so3480876wmi.5
 for <qemu-devel@nongnu.org>; Tue, 04 Aug 2020 09:15:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=references:user-agent:from:to:cc:subject:in-reply-to:date
 :message-id:mime-version:content-transfer-encoding;
 bh=367oMtrM0LWp250z5gAKy1NqmlciNQn2qzt3sI9J+Hw=;
 b=IoY20AyPcIucOGRoQfTPSiThLqzyzrD+UXPmMJ3nf9rb6KBtTpfYxdaMaiCJ161ouF
 WrmOokwNSRaTTgAlbPvTNgsVGy1kbJG6sJPtnrSliQKXKOxodFd0zu3m/DO0A3bVSgoC
 7eIOFtI7EXCZbtbFWRMxH7hO66f+l+2ok0ILtAEGu89RRDbOvOKHnCkO+fPD7KHrMZ2q
 A3oxfbIGy0/C3lYziA6FrT+scic0hrNz/1EwrDaiF58P5cnHqDiw3yGNOJUQpYbCUCKv
 6uXM6nwN4JlwqScjsahnZiUSvMBZ3l1Xip6m7ykKZaEBS1ID+3E01bac1Fx1ve0EvKj0
 YORQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
 bh=367oMtrM0LWp250z5gAKy1NqmlciNQn2qzt3sI9J+Hw=;
 b=QnDLJB+IfiuL8SRexv5Aj4hx69I4Zl/4KaajkTkg4OJUXmjjSxRsbOvlDomTvW2cJ0
 TYpmisJ8FCh4x+c8AVBh3DLt0z7JhGAMdCv90UIy6wtuVesAhtuq+dynimEWGm5fCgXM
 SfoZMAV/7+qWsY4CLxesBmOTUXRnHEcZJJECTXwFKP/CTwllLPLROY77mwJzn7SVRJBo
 fb4hv7MdOL4DCkP3G8cqDfNi/p2a3/Dc9+gVM51e790V76YS6EXphRjIw3nlcoccc4pG
 tu5AzS4NL85Ol4rDtIF55difpj87SFIvBuvyTwvZnmE5Jv4n1C5bSi68jzct06QOhyYG
 rKmA==
X-Gm-Message-State: AOAM530yGdSILA+4qCmcrT7WdxpSVkyIKqJ8ugiqYtrPkc7In9GylrAv
 Ieowky9RumNWg8sL3LzPyh0Q9w==
X-Google-Smtp-Source: ABdhPJxolubboifvZRASzi6sQKNg3l9sXb8pCJaB/yE9S1kBhXYBsF58Td6cjzabbwhUOEfEL+zPlg==
X-Received: by 2002:a05:600c:2246:: with SMTP id
 a6mr4870524wmm.71.1596557704254; 
 Tue, 04 Aug 2020 09:15:04 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id q4sm5077473wme.31.2020.08.04.09.15.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 04 Aug 2020 09:15:02 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 3837D1FF7E;
 Tue,  4 Aug 2020 17:15:02 +0100 (BST)
References: <20200730141326.8260-1-thuth@redhat.com>
 <20200730141326.8260-4-thuth@redhat.com>
User-agent: mu4e 1.5.5; emacs 28.0.50
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Thomas Huth <thuth@redhat.com>
Subject: Re: [PATCH v2 3/4] gitlab-ci.yml: Add build-system-debian and
 build-system-centos jobs
In-reply-to: <20200730141326.8260-4-thuth@redhat.com>
Date: Tue, 04 Aug 2020 17:15:02 +0100
Message-ID: <87a6zamlq1.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::342;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x342.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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
Cc: Yoshinori Sato <ysato@users.sourceforge.jp>, qemu-devel@nongnu.org,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Pavel Dovgalyuk <pavel.dovgaluk@ispras.ru>, Cleber Rosa <crosa@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


Thomas Huth <thuth@redhat.com> writes:

> We were missing the two new targets avr-softmmu and rx-softmmu in the
> gitlab-CI so far, and did not add some of the "other endianess" targets
> like sh4eb-softmmu yet.
> Since the current build-system-* jobs run already for a very long time,
> let's do not add these missing targets there, but introduce two new
> additional build jobs, one running with Debian and one running with
> CentOS, and add the new targets there. Also move some targets from
> the old build-system-* jobs to these new targets, to distribute the
> load and reduce the runtime of the CI.
>
> Signed-off-by: Thomas Huth <thuth@redhat.com>

Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

--=20
Alex Benn=C3=A9e

