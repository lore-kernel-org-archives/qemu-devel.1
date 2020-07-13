Return-Path: <SRS0=6r5r=AY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CCC1DC433E1
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Jul 2020 19:27:57 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A594220663
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Jul 2020 19:27:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A594220663
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52524 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jv47J-0002lJ-0T
	for qemu-devel@archiver.kernel.org; Mon, 13 Jul 2020 15:27:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44048)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>) id 1jv46a-0001Wu-R1
 for qemu-devel@nongnu.org; Mon, 13 Jul 2020 15:27:12 -0400
Received: from mout.kundenserver.de ([217.72.192.75]:52371)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>) id 1jv46Y-00077C-Et
 for qemu-devel@nongnu.org; Mon, 13 Jul 2020 15:27:12 -0400
Received: from [192.168.100.1] ([78.238.229.36]) by mrelayeu.kundenserver.de
 (mreue108 [213.165.67.119]) with ESMTPSA (Nemesis) id
 1MVvGt-1kKfTV1lB7-00Rt8M for <qemu-devel@nongnu.org>; Mon, 13 Jul 2020
 21:27:08 +0200
Subject: Re: [PATCH 2/2] linux-user: add netlink RTM_SETLINK command
To: qemu-devel@nongnu.org
References: <20200709072332.890440-1-laurent@vivier.eu>
 <20200709072332.890440-2-laurent@vivier.eu>
From: Laurent Vivier <laurent@vivier.eu>
Autocrypt: addr=laurent@vivier.eu; prefer-encrypt=mutual; keydata=
 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
Message-ID: <9efc5cb1-a059-4c8f-cb9a-88f80a031990@vivier.eu>
Date: Mon, 13 Jul 2020 21:27:07 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <20200709072332.890440-2-laurent@vivier.eu>
Content-Type: text/plain; charset=utf-8
Content-Language: fr
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:jcG7+nIsxKNcw2n+4aazdaUI0bnN53FkT+DTwTBWM9Jm6ETFa6I
 ISWtKhDtG2LoHW6AZIZ+Vv3+qDo6gEId8Iv5RQQi3dL8cM13rJhkaYab5UE8KHteQVz9t4m
 asO6XLdDN7mTg9/fq2xTWoDy1Ey4KDrP3jkrSS/fdn8fYzVdb09Q65lBsfX3SR8XKHbw5hs
 5g7Lpc905vRCbqfp9jqzQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:wqdBKWebF2k=:XhOkQXlALyp0r16zK5sQ2x
 6KpRtJIBB0XDE9Te9yGAV/1Lv1DdNkCN4CNo1dC0UMMw6jwnUFqW/AYf64mUjJyISCkeEOC4E
 ClLj7M/TR12ALXGP6y0eJlunXgULrlZm9RYNMIUsqnlt4uQzgHfFKHSjw3xx8Wq2n1cfVMrlu
 CsuqC/zgf4Z9r0BgtslK2HUAN5kccx8fzkIT7nEF9g2DjI6tP4b3/NH5Mf3wBoG5fbIlYUDtb
 Jc1WQBDl0lh1DUmAQVfZY52x6spHOgyPAdrWpHCDXemD5jcep98UI3Gl0zPvZp1OmqKzvCFCM
 KrUdqDafpZAgWBP1I5HmPf8OfRicQJleE1v1tv921QIzOn3mVP0c4GsPjYVxXwgtxPIDfUUv2
 /Ad+yqDodcEwPhOFMjtanKbfRyTt7/CF+y+WEOjTs023WJcilXJqvtJ7fv2iQSZ1Lxc0YEujY
 pnt+nlMldrsubsc9yNSoyAvaagWHUl7eGt3yMnGUMukc0DRl5AX0rCFxWeFq3RHTjrqYA/RvB
 E1yJdk22l0qZQANcIyBh2CqyUno6SADg9iNkfPqKl6EWN4hmCu45yYez++zSmTJXVkCcNsPMg
 7pdqvY7FqCoJTGhpI8hMYIwAJsCtgwVrM1GxcekDHs4+PJn/Ou2iLgVSDBJ5CtaYBZniUqq/S
 nR4lWwoNhHLdA/qiyg3uVirOFVgnsmm8SrgtEr7r04UbPIRbhMrrksZuXiVy0pBXeLW0PpL0g
 FGFfgpi3eRHSBEA6yXa2p99OD27KCLGYUzmH7LDBuBLErUBLrQiDCkjwxKDQUurR2u36Yj36o
 pYvTfqmj/D2x4U8c3o+8MHe4duRlCLS4q8kOwvvXlgiXMRQRmoi+EKjCgcd/zZhwcEQH4Yz
Received-SPF: none client-ip=217.72.192.75; envelope-from=laurent@vivier.eu;
 helo=mout.kundenserver.de
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/13 14:46:47
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic]
X-Spam_score_int: -28
X-Spam_score: -2.9
X-Spam_bar: --
X-Spam_report: (-2.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H2=-1, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=ham autolearn_force=no
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

Le 09/07/2020 à 09:23, Laurent Vivier a écrit :
> This command is needed to be able to boot systemd in a container.
> 
>   $ sudo systemd-nspawn -D /chroot/armhf/sid/ -b
>   Spawning container sid on /chroot/armhf/sid.
>   Press ^] three times within 1s to kill container.
>   systemd 245.6-2 running in system mode.
>   Detected virtualization systemd-nspawn.
>   Detected architecture arm.
> 
>   Welcome to Debian GNU/Linux bullseye/sid!
> 
>   Set hostname to <virt-arm>.
>   Failed to enqueue loopback interface start request: Operation not supported
>   Caught <SEGV>, dumped core as pid 3.
>   Exiting PID 1...
>   Container sid failed with error code 255.
> 
> Signed-off-by: Laurent Vivier <laurent@vivier.eu>
> ---
>  linux-user/fd-trans.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/linux-user/fd-trans.c b/linux-user/fd-trans.c
> index 5d49a53552b2..1486c81aaa27 100644
> --- a/linux-user/fd-trans.c
> +++ b/linux-user/fd-trans.c
> @@ -1204,6 +1204,7 @@ static abi_long target_to_host_data_route(struct nlmsghdr *nlh)
>          break;
>      case RTM_NEWLINK:
>      case RTM_DELLINK:
> +    case RTM_SETLINK:
>          if (nlh->nlmsg_len >= NLMSG_LENGTH(sizeof(*ifi))) {
>              ifi = NLMSG_DATA(nlh);
>              ifi->ifi_type = tswap16(ifi->ifi_type);
> 

Applied to my linux-user-for-5.1 branch.

Thanks,
Laurent

