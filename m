Return-Path: <SRS0=QduX=3Y=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90EF3C35247
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Feb 2020 21:11:41 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6168021741
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Feb 2020 21:11:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6168021741
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38218 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iz5Tw-0004Lr-Gi
	for qemu-devel@archiver.kernel.org; Tue, 04 Feb 2020 16:11:40 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:45638)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <laurent@vivier.eu>) id 1iz5Sv-0003YL-L0
 for qemu-devel@nongnu.org; Tue, 04 Feb 2020 16:10:38 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <laurent@vivier.eu>) id 1iz5Su-00089w-AL
 for qemu-devel@nongnu.org; Tue, 04 Feb 2020 16:10:37 -0500
Received: from mout.kundenserver.de ([217.72.192.73]:49217)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <laurent@vivier.eu>) id 1iz5Su-0007v2-0a
 for qemu-devel@nongnu.org; Tue, 04 Feb 2020 16:10:36 -0500
Received: from [192.168.100.1] ([78.238.229.36]) by mrelayeu.kundenserver.de
 (mreue106 [213.165.67.119]) with ESMTPSA (Nemesis) id
 1Mna0x-1jQCXD0Vbp-00jZmA; Tue, 04 Feb 2020 22:10:22 +0100
Subject: Re: [PATCH] linux-user: implement TARGET_SO_PEERSEC
To: qemu-devel@nongnu.org
References: <20200203173724.1601021-1-laurent@vivier.eu>
From: Laurent Vivier <laurent@vivier.eu>
Autocrypt: addr=laurent@vivier.eu; prefer-encrypt=mutual; keydata=
 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
Message-ID: <67c849d7-43ae-2d1d-af40-1850d886d5b6@vivier.eu>
Date: Tue, 4 Feb 2020 22:10:18 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.1
MIME-Version: 1.0
In-Reply-To: <20200203173724.1601021-1-laurent@vivier.eu>
Content-Type: text/plain; charset=utf-8
Content-Language: fr
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:X3qkiuMVLKiiHWRatYyM8RVhaQ72i7/WGRFzp3dIP27+/qBqz8v
 Fdm3/g2xbiBorB+XclX4+LNYRQgGDF1El8NBdHZUziygoStHZdh6GIqm2f3H6wa1joF3NZl
 dpXquovKbOhv7gpxs0SJiL7F3Galv+IUEanG7AnTUTv2BLw54d3/K9dqIeBiI+P3rDDOZp6
 2tRs11yeC7b2ELoYjsnjA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:/6tL0/i+oj0=:HzY0edMkLM5ALzBt1Sh+jb
 yns129k9e6KEi3uzsXe2tD64NYMH5eYpeShg9GwhSVw3xJqybgqBjDqC40Kwqf1LYhcEb6nb9
 Utzw9Jt9VhBg+qg3BHY/jwvm86h96g4P19mH9N+DW6B0uIbLW3S7SBD5hWwhV9YT/1UCSCJlo
 2WZN6tUO3FBJ8w9Ny0o47uiy3BYr0eZ0X2aZGH3xdEJpU5bsG3XHJj71e08ixLfXnirKouUut
 EDSBZfWqqcHj9tcelUjTopDfOMHPRRYeJj4DBqKr1iulqBKOFSBHS1uyydT0g1ZlhvEC/eff+
 Ewk8GxQ/o6GkqLKs+lzA7IeP4pZ3Bgv/NcxHkfTdjHwn5iLFTPtTV65ZYU9MlrqElkgXlYPzI
 +uXaTgKammSnUvliyG/OaoHki2B+Wkn9tH36BDOEXtr1aNb/SWOr2UnAnFLsWymdSNXHIHtia
 zUDltjL3URviUpagQ0AW9yFAEGGatKSdOzg8kjViWwtOYNauky86CbAB7Par5r0uE0Pf7bowg
 n2haxXFc9JWk7j3Zh8fJ65qTHBYu0iFMSGxPncFvximpjEhMDXRwm2FDwjfFtJDQyLYz84a9T
 xNJR0FQZ05bLBtOujrXyAu+43miw2ZQyhYxBvEbx6Ev3Fx9iaZq64JPKMO3I8l0GMZHR8ePLr
 Fc3H3TfAPiAmBQEFT523JPumdsFj2TQcBgWCDe3MT8VVUxZDrGs8idZaSBq0Z22eJPPw8DgzE
 RFJ1rFgzcGuNtEWp/65bSxD2/aYq079r7PZQ3AqJNg9yolD6u2anoxyVO6QnL8CSUaS8ySPRR
 PloJwLUDIntazqV39EIJt7OT5EKyx5Cj9FCOAlhu8izABvGTDJLugnYHrKFfiSBYvBKVRfo
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 217.72.192.73
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
Cc: Riku Voipio <riku.voipio@iki.fi>,
 =?UTF-8?Q?Matthias_L=c3=bcscher?= <lueschem@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Le 03/02/2020 à 18:37, Laurent Vivier a écrit :
> "The purpose of this option is to allow an application to obtain the
> security credentials of a Unix stream socket peer.  It is analogous to
> SO_PEERCRED (which provides authentication using standard Unix credentials
> of pid, uid and gid), and extends this concept to other security
> models." -- https://lwn.net/Articles/62370/
> 
> Until now it was passed to the kernel with an "int" argument and
> fails when it was supported by the host because the parameter is
> like a filename: it is always a \0-terminated string with no embedded
> \0 characters, but is not guaranteed to be ASCII or UTF-8.
> 
> I've tested the option with the following program:
> 
>     /*
>      * cc -o getpeercon getpeercon.c
>      */
> 
>     #include <stdio.h>
>     #include <sys/types.h>
>     #include <sys/socket.h>
>     #include <netinet/in.h>
>     #include <arpa/inet.h>
> 
>     int main(void)
>     {
>         int fd;
>         struct sockaddr_in server, addr;
>         int ret;
>         socklen_t len;
>         char buf[256];
> 
>         fd = socket(PF_INET, SOCK_STREAM, 0);
>         if (fd == -1) {
>             perror("socket");
>             return 1;
>         }
> 
>         server.sin_family = AF_INET;
>         inet_aton("127.0.0.1", &server.sin_addr);
>         server.sin_port = htons(40390);
> 
>         connect(fd, (struct sockaddr*)&server, sizeof(server));
> 
>         len = sizeof(buf);
>         ret = getsockopt(fd, SOL_SOCKET, SO_PEERSEC, buf, &len);
>         if (ret == -1) {
>             perror("getsockopt");
>             return 1;
>         }
>         printf("%d %s\n", len, buf);
>         return 0;
>     }
> 
> On host:
> 
>   $ ./getpeercon
>   33 system_u:object_r:unlabeled_t:s0
> 
> With qemu-aarch64/bionic without the patch:
> 
>   $ ./getpeercon
>   getsockopt: Numerical result out of range
> 
> With the patch:
> 
>   $ ./getpeercon
>   33 system_u:object_r:unlabeled_t:s0
> 
> Bug: https://bugs.launchpad.net/qemu/+bug/1823790
> Reported-by: Matthias Lüscher <lueschem@gmail.com>
> Tested-by: Matthias Lüscher <lueschem@gmail.com>
> Signed-off-by: Laurent Vivier <laurent@vivier.eu>
> ---
>  linux-user/syscall.c | 22 ++++++++++++++++++++++
>  1 file changed, 22 insertions(+)
> 
> diff --git a/linux-user/syscall.c b/linux-user/syscall.c
> index d60142f0691c..5f37e62772de 100644
> --- a/linux-user/syscall.c
> +++ b/linux-user/syscall.c
> @@ -2344,6 +2344,28 @@ static abi_long do_getsockopt(int sockfd, int level, int optname,
>              }
>              break;
>          }
> +        case TARGET_SO_PEERSEC: {
> +            char *name;
> +
> +            if (get_user_u32(len, optlen)) {
> +                return -TARGET_EFAULT;
> +            }
> +            if (len < 0) {
> +                return -TARGET_EINVAL;
> +            }
> +            name = lock_user(VERIFY_WRITE, optval_addr, len, 0);
> +            if (!name) {
> +                return -TARGET_EFAULT;
> +            }
> +            lv = len;
> +            ret = get_errno(getsockopt(sockfd, level, SO_PEERSEC,
> +                                       name, &lv));
> +            if (put_user_u32(lv, optlen)) {
> +                ret = -TARGET_EFAULT;
> +            }
> +            unlock_user(name, optval_addr, 0);

There is an error here, "0" must be "lv".

I update and resend.

Thanks,
Laurent

