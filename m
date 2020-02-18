Return-Path: <SRS0=v1sw=4G=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32E25C34026
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Feb 2020 20:07:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F25B32067D
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Feb 2020 20:07:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F25B32067D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41438 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j499y-0002Jo-1p
	for qemu-devel@archiver.kernel.org; Tue, 18 Feb 2020 15:07:58 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:36799)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <laurent@vivier.eu>) id 1j498S-0001LH-UA
 for qemu-devel@nongnu.org; Tue, 18 Feb 2020 15:06:26 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <laurent@vivier.eu>) id 1j498P-0002D0-1I
 for qemu-devel@nongnu.org; Tue, 18 Feb 2020 15:06:24 -0500
Received: from mout.kundenserver.de ([212.227.126.187]:40945)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <laurent@vivier.eu>) id 1j498O-00029j-NV
 for qemu-devel@nongnu.org; Tue, 18 Feb 2020 15:06:20 -0500
Received: from [192.168.100.1] ([78.238.229.36]) by mrelayeu.kundenserver.de
 (mreue011 [213.165.67.103]) with ESMTPSA (Nemesis) id
 1MJVY8-1ikHtS2jAu-00JsI9; Tue, 18 Feb 2020 21:06:02 +0100
Subject: Re: [PATCH v3 1/4] linux-user: Use `qemu_log' for non-strace logging
To: Josh Kunz <jkz@google.com>, qemu-devel@nongnu.org
References: <20200204025416.111409-1-jkz@google.com>
 <20200204025416.111409-2-jkz@google.com>
From: Laurent Vivier <laurent@vivier.eu>
Autocrypt: addr=laurent@vivier.eu; prefer-encrypt=mutual; keydata=
 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
Message-ID: <d35bd139-e59a-4fc1-5dc6-866d4e45afc0@vivier.eu>
Date: Tue, 18 Feb 2020 21:05:58 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200204025416.111409-2-jkz@google.com>
Content-Type: text/plain; charset=utf-8
Content-Language: fr
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:PH/bqzFcnMcNABxrQZyGAvPX3X82MoWtl83XkUg2L1YYONSwvYR
 4rhc+1DYS0F7MpSfQ7s0NnldWH0dV5h7c3GW0s5bADF4hJxITogMWtfMbNKxzf7M0Y60ybY
 t7PcwIf9HC/RKAzB5w9yi0WG7wf8i2x64pno2DuD5Lp/xvY2kEbBV5dtbIDY3ouDK4AWHyg
 dlpb63Ab5thFaNyRafEDw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:idZ4uAERyoc=:VmoLU+iT4LYIXUubed2OKO
 IrWVbqmCoxiQ1ByvwYyXO4P5j6d3Z8iT2x6JiOvr5P5FkQ22dWSwdBYFLq0MhDozN68FG+ii+
 w2LkztlZIHPWA/zN6h9CGco+1BjqQu4DKDSFd0tvF4wzsheaYjZPylajYViElu9cHXgw2NaW/
 IWZPAmJtpiOpWQxXbEPRtGY2r+I5ynS8Cpn4MS0KqFTk1RQXv3XDfJmiu9lBatzklJK3d3Ncn
 JDv6E8VAhn/2BuStuRru49ZL2KSfA8840R1jE6o5WVBQnw6YcPGk6V8ht77HECOhW86Q3l0Hq
 jo6+hFYmnhof9CIaLvdyrkZQJt2X+dEGl4rxPH96Dl6nKn4mB4CPc7RzsC6pcWmTLayDjC2n7
 v0hvMAXbsNuBSE5KzNWDieAF4RWsN2O9pRYJwDjuZge6Br58/MqOH25mEA1hlnRUHOte8ArzY
 Xbh+R+o0lugh115qo5j8IZFWPNm+fKNx5lo3OotHFgicOI9yenw3oVQNnuZg7cArevpQclGtn
 VTvPfm8bsyco16SpDd3xE0EV9mK15m6NXAoaYlOrKZOiAeFSUv9/ukHMumIHXDUaDY7FMPfqD
 1vapG4oX043PH0GODSbIGGJ8T5lhzZvpgYyaet/+QIrQUDDG20gOPfYXVr3rWxrPOvBddeQel
 wpjMzA8Bsq00E/UmcVs7f2CXjfXCR2RO3dG9N0ZSIban+A0vb+m5PzUDvHmMzL+E5PrLzG+Au
 CNpHdBiGDdd/mLYK0zSeiGGUT2DajfXVrpL+C8qqp6N+sAHU14imgvd3sr+wb5W+TmexySFWc
 4Z6TJkJoJKjNCEvG4gCk+jR+zbO3seY/B5whIsuI3nt0ZDxhwSBgN8b3NJOMUcIk8/2G+F6
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 212.227.126.187
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
Cc: riku.voipio@iki.fi, alex.bennee@linaro.org, armbru@redhat.com,
 imp@bsdimp.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Le 04/02/2020 à 03:54, Josh Kunz a écrit :
> Since most calls to `gemu_log` are actually logging unimplemented features,
> this change replaces most non-strace calls to `gemu_log` with calls to
> `qemu_log_mask(LOG_UNIMP, ...)`.  This allows the user to easily log to
> a file, and to mask out these log messages if they desire.
> 
> Note: This change is slightly backwards incompatible, since now these
> "unimplemented" log messages will not be logged by default.
> 
> Signed-off-by: Josh Kunz <jkz@google.com>
> ---
>  linux-user/arm/cpu_loop.c |  5 ++--
>  linux-user/fd-trans.c     | 55 +++++++++++++++++++++++++--------------
>  linux-user/syscall.c      | 35 ++++++++++++++++---------
>  linux-user/vm86.c         |  3 ++-
>  4 files changed, 62 insertions(+), 36 deletions(-)
> 
> diff --git a/linux-user/arm/cpu_loop.c b/linux-user/arm/cpu_loop.c
> index 1fae90c6df..cf618daa1c 100644
> --- a/linux-user/arm/cpu_loop.c
> +++ b/linux-user/arm/cpu_loop.c
> @@ -349,8 +349,9 @@ void cpu_loop(CPUARMState *env)
>                              env->regs[0] = cpu_get_tls(env);
>                              break;
>                          default:
> -                            gemu_log("qemu: Unsupported ARM syscall: 0x%x\n",
> -                                     n);
> +                            qemu_log_mask(LOG_UNIMP,
> +                                          "qemu: Unsupported ARM syscall: 0x%x\n",
> +                                          n);
>                              env->regs[0] = -TARGET_ENOSYS;
>                              break;
>                          }
> diff --git a/linux-user/fd-trans.c b/linux-user/fd-trans.c
> index 9b92386abf..c0687c52e6 100644
> --- a/linux-user/fd-trans.c
> +++ b/linux-user/fd-trans.c
> @@ -514,7 +514,8 @@ static abi_long host_to_target_data_bridge_nlattr(struct nlattr *nlattr,
>          u32[1] = tswap32(u32[1]); /* optmask */
>          break;
>      default:
> -        gemu_log("Unknown QEMU_IFLA_BR type %d\n", nlattr->nla_type);
> +        qemu_log_mask(LOG_UNIMP, "Unknown QEMU_IFLA_BR type %d\n",
> +                      nlattr->nla_type);
>          break;
>      }
>      return 0;
> @@ -577,7 +578,8 @@ static abi_long host_to_target_slave_data_bridge_nlattr(struct nlattr *nlattr,
>      case QEMU_IFLA_BRPORT_BRIDGE_ID:
>          break;
>      default:
> -        gemu_log("Unknown QEMU_IFLA_BRPORT type %d\n", nlattr->nla_type);
> +        qemu_log_mask(LOG_UNIMP, "Unknown QEMU_IFLA_BRPORT type %d\n",
> +                      nlattr->nla_type);
>          break;
>      }
>      return 0;
> @@ -605,7 +607,8 @@ static abi_long host_to_target_data_tun_nlattr(struct nlattr *nlattr,
>          *u32 = tswap32(*u32);
>          break;
>      default:
> -        gemu_log("Unknown QEMU_IFLA_TUN type %d\n", nlattr->nla_type);
> +        qemu_log_mask(LOG_UNIMP, "Unknown QEMU_IFLA_TUN type %d\n",
> +                      nlattr->nla_type);
>          break;
>      }
>      return 0;
> @@ -652,7 +655,8 @@ static abi_long host_to_target_data_linkinfo_nlattr(struct nlattr *nlattr,
>                                                    NULL,
>                                                  host_to_target_data_tun_nlattr);
>          } else {
> -            gemu_log("Unknown QEMU_IFLA_INFO_KIND %s\n", li_context->name);
> +            qemu_log_mask(LOG_UNIMP, "Unknown QEMU_IFLA_INFO_KIND %s\n",
> +                          li_context->name);
>          }
>          break;
>      case QEMU_IFLA_INFO_SLAVE_DATA:
> @@ -663,12 +667,13 @@ static abi_long host_to_target_data_linkinfo_nlattr(struct nlattr *nlattr,
>                                                    NULL,
>                                         host_to_target_slave_data_bridge_nlattr);
>          } else {
> -            gemu_log("Unknown QEMU_IFLA_INFO_SLAVE_KIND %s\n",
> +            qemu_log_mask(LOG_UNIMP, "Unknown QEMU_IFLA_INFO_SLAVE_KIND %s\n",
>                       li_context->slave_name);
>          }
>          break;
>      default:
> -        gemu_log("Unknown host QEMU_IFLA_INFO type: %d\n", nlattr->nla_type);
> +        qemu_log_mask(LOG_UNIMP, "Unknown host QEMU_IFLA_INFO type: %d\n",
> +                      nlattr->nla_type);
>          break;
>      }
>  
> @@ -690,7 +695,8 @@ static abi_long host_to_target_data_inet_nlattr(struct nlattr *nlattr,
>          }
>          break;
>      default:
> -        gemu_log("Unknown host AF_INET type: %d\n", nlattr->nla_type);
> +        qemu_log_mask(LOG_UNIMP, "Unknown host AF_INET type: %d\n",
> +                      nlattr->nla_type);
>      }
>      return 0;
>  }
> @@ -741,7 +747,8 @@ static abi_long host_to_target_data_inet6_nlattr(struct nlattr *nlattr,
>          }
>          break;
>      default:
> -        gemu_log("Unknown host AF_INET6 type: %d\n", nlattr->nla_type);
> +        qemu_log_mask(LOG_UNIMP, "Unknown host AF_INET6 type: %d\n",
> +                      nlattr->nla_type);
>      }
>      return 0;
>  }
> @@ -759,7 +766,8 @@ static abi_long host_to_target_data_spec_nlattr(struct nlattr *nlattr,
>                                                NULL,
>                                               host_to_target_data_inet6_nlattr);
>      default:
> -        gemu_log("Unknown host AF_SPEC type: %d\n", nlattr->nla_type);
> +        qemu_log_mask(LOG_UNIMP, "Unknown host AF_SPEC type: %d\n",
> +                      nlattr->nla_type);
>          break;
>      }
>      return 0;
> @@ -780,7 +788,8 @@ static abi_long host_to_target_data_xdp_nlattr(struct nlattr *nlattr,
>          *u32 = tswap32(*u32);
>          break;
>      default:
> -        gemu_log("Unknown host XDP type: %d\n", nlattr->nla_type);
> +        qemu_log_mask(
> +            LOG_UNIMP, "Unknown host XDP type: %d\n", nlattr->nla_type);
>          break;
>      }
>      return 0;
> @@ -920,7 +929,8 @@ static abi_long host_to_target_data_link_rtattr(struct rtattr *rtattr)
>                                                NULL,
>                                                  host_to_target_data_xdp_nlattr);
>      default:
> -        gemu_log("Unknown host QEMU_IFLA type: %d\n", rtattr->rta_type);
> +        qemu_log_mask(LOG_UNIMP, "Unknown host QEMU_IFLA type: %d\n",
> +                      rtattr->rta_type);
>          break;
>      }
>      return 0;
> @@ -954,7 +964,8 @@ static abi_long host_to_target_data_addr_rtattr(struct rtattr *rtattr)
>          ci->tstamp = tswap32(ci->tstamp);
>          break;
>      default:
> -        gemu_log("Unknown host IFA type: %d\n", rtattr->rta_type);
> +        qemu_log_mask(
> +            LOG_UNIMP, "Unknown host IFA type: %d\n", rtattr->rta_type);
>          break;
>      }
>      return 0;
> @@ -996,7 +1007,8 @@ static abi_long host_to_target_data_route_rtattr(struct rtattr *rtattr)
>  #endif
>          break;
>      default:
> -        gemu_log("Unknown host RTA type: %d\n", rtattr->rta_type);
> +        qemu_log_mask(
> +            LOG_UNIMP, "Unknown host RTA type: %d\n", rtattr->rta_type);
>          break;
>      }
>      return 0;
> @@ -1111,7 +1123,8 @@ static abi_long target_to_host_data_link_rtattr(struct rtattr *rtattr)
>  {
>      switch (rtattr->rta_type) {
>      default:
> -        gemu_log("Unknown target QEMU_IFLA type: %d\n", rtattr->rta_type);
> +        qemu_log_mask(LOG_UNIMP, "Unknown target QEMU_IFLA type: %d\n",
> +                      rtattr->rta_type);
>          break;
>      }
>      return 0;
> @@ -1125,7 +1138,8 @@ static abi_long target_to_host_data_addr_rtattr(struct rtattr *rtattr)
>      case IFA_ADDRESS:
>          break;
>      default:
> -        gemu_log("Unknown target IFA type: %d\n", rtattr->rta_type);
> +        qemu_log_mask(LOG_UNIMP, "Unknown target IFA type: %d\n",
> +                      rtattr->rta_type);
>          break;
>      }
>      return 0;
> @@ -1147,7 +1161,8 @@ static abi_long target_to_host_data_route_rtattr(struct rtattr *rtattr)
>          *u32 = tswap32(*u32);
>          break;
>      default:
> -        gemu_log("Unknown target RTA type: %d\n", rtattr->rta_type);
> +        qemu_log_mask(LOG_UNIMP, "Unknown target RTA type: %d\n",
> +                      rtattr->rta_type);
>          break;
>      }
>      return 0;
> @@ -1232,8 +1247,8 @@ static abi_long host_to_target_data_audit(struct nlmsghdr *nlh)
>  {
>      switch (nlh->nlmsg_type) {
>      default:
> -        gemu_log("Unknown host audit message type %d\n",
> -                 nlh->nlmsg_type);
> +        qemu_log_mask(LOG_UNIMP, "Unknown host audit message type %d\n",
> +                      nlh->nlmsg_type);
>          return -TARGET_EINVAL;
>      }
>      return 0;
> @@ -1253,8 +1268,8 @@ static abi_long target_to_host_data_audit(struct nlmsghdr *nlh)
>      case AUDIT_FIRST_USER_MSG2 ... AUDIT_LAST_USER_MSG2:
>          break;
>      default:
> -        gemu_log("Unknown target audit message type %d\n",
> -                 nlh->nlmsg_type);
> +        qemu_log_mask(LOG_UNIMP, "Unknown target audit message type %d\n",
> +                      nlh->nlmsg_type);
>          return -TARGET_EINVAL;
>      }
>  
> diff --git a/linux-user/syscall.c b/linux-user/syscall.c
> index d60142f069..c48c2a9a55 100644
> --- a/linux-user/syscall.c
> +++ b/linux-user/syscall.c
> @@ -1560,7 +1560,11 @@ static inline abi_long target_to_host_cmsg(struct msghdr *msgh,
>               * something more intelligent than "twice the size of the
>               * target buffer we're reading from".
>               */
> -            gemu_log("Host cmsg overflow\n");
> +            qemu_log_mask(LOG_UNIMP,
> +                          ("Unsupported ancillary data %d/%d: "
> +                           "unhandled msg size\n"),
> +                          tswap32(target_cmsg->cmsg_level),
> +                          tswap32(target_cmsg->cmsg_type));
>              break;
>          }
>  
> @@ -1590,8 +1594,8 @@ static inline abi_long target_to_host_cmsg(struct msghdr *msgh,
>              __get_user(cred->uid, &target_cred->uid);
>              __get_user(cred->gid, &target_cred->gid);
>          } else {
> -            gemu_log("Unsupported ancillary data: %d/%d\n",
> -                                        cmsg->cmsg_level, cmsg->cmsg_type);
> +            qemu_log_mask(LOG_UNIMP, "Unsupported ancillary data: %d/%d\n",
> +                          cmsg->cmsg_level, cmsg->cmsg_type);
>              memcpy(data, target_data, len);
>          }
>  
> @@ -1812,8 +1816,8 @@ static inline abi_long host_to_target_cmsg(struct target_msghdr *target_msgh,
>  
>          default:
>          unimplemented:
> -            gemu_log("Unsupported ancillary data: %d/%d\n",
> -                                        cmsg->cmsg_level, cmsg->cmsg_type);
> +            qemu_log_mask(LOG_UNIMP, "Unsupported ancillary data: %d/%d\n",
> +                          cmsg->cmsg_level, cmsg->cmsg_type);
>              memcpy(target_data, data, MIN(len, tgt_len));
>              if (tgt_len > len) {
>                  memset(target_data + len, 0, tgt_len - len);
> @@ -2288,7 +2292,8 @@ set_timeout:
>  #endif /* SOL_NETLINK */
>      default:
>      unimplemented:
> -        gemu_log("Unsupported setsockopt level=%d optname=%d\n", level, optname);
> +        qemu_log_mask(LOG_UNIMP, "Unsupported setsockopt level=%d optname=%d\n",
> +                      level, optname);
>          ret = -TARGET_ENOPROTOOPT;
>      }
>      return ret;
> @@ -2641,8 +2646,9 @@ static abi_long do_getsockopt(int sockfd, int level, int optname,
>  #endif /* SOL_NETLINK */
>      default:
>      unimplemented:
> -        gemu_log("getsockopt level=%d optname=%d not yet supported\n",
> -                 level, optname);
> +        qemu_log_mask(LOG_UNIMP,
> +                      "getsockopt level=%d optname=%d not yet supported\n",
> +                      level, optname);
>          ret = -TARGET_EOPNOTSUPP;
>          break;
>      }
> @@ -3397,7 +3403,7 @@ static abi_long do_socketcall(int num, abi_ulong vptr)
>      case TARGET_SYS_SENDMMSG: /* sockfd, msgvec, vlen, flags */
>          return do_sendrecvmmsg(a[0], a[1], a[2], a[3], 1);
>      default:
> -        gemu_log("Unsupported socketcall: %d\n", num);
> +        qemu_log_mask(LOG_UNIMP, "Unsupported socketcall: %d\n", num);
>          return -TARGET_EINVAL;
>      }
>  }
> @@ -4308,7 +4314,8 @@ static abi_long do_ipc(CPUArchState *cpu_env,
>          ret = do_shmctl(first, second, ptr);
>          break;
>      default:
> -	gemu_log("Unsupported ipc call: %d (version %d)\n", call, version);
> +        qemu_log_mask(LOG_UNIMP, "Unsupported ipc call: %d (version %d)\n",
> +                      call, version);
>  	ret = -TARGET_ENOSYS;
>  	break;
>      }
> @@ -5156,7 +5163,8 @@ static abi_long do_ioctl(int fd, int cmd, abi_long arg)
>      ie = ioctl_entries;
>      for(;;) {
>          if (ie->target_cmd == 0) {
> -            gemu_log("Unsupported ioctl: cmd=0x%04lx\n", (long)cmd);
> +            qemu_log_mask(
> +                LOG_UNIMP, "Unsupported ioctl: cmd=0x%04lx\n", (long)cmd);
>              return -TARGET_ENOSYS;
>          }
>          if (ie->target_cmd == cmd)
> @@ -5224,8 +5232,9 @@ static abi_long do_ioctl(int fd, int cmd, abi_long arg)
>          }
>          break;
>      default:
> -        gemu_log("Unsupported ioctl type: cmd=0x%04lx type=%d\n",
> -                 (long)cmd, arg_type[0]);
> +        qemu_log_mask(LOG_UNIMP,
> +                      "Unsupported ioctl type: cmd=0x%04lx type=%d\n",
> +                      (long)cmd, arg_type[0]);
>          ret = -TARGET_ENOSYS;
>          break;
>      }
> diff --git a/linux-user/vm86.c b/linux-user/vm86.c
> index 2fa7a89edc..4412522c4c 100644
> --- a/linux-user/vm86.c
> +++ b/linux-user/vm86.c
> @@ -402,7 +402,8 @@ int do_vm86(CPUX86State *env, long subfunction, abi_ulong vm86_addr)
>      case TARGET_VM86_FREE_IRQ:
>      case TARGET_VM86_GET_IRQ_BITS:
>      case TARGET_VM86_GET_AND_RESET_IRQ:
> -        gemu_log("qemu: unsupported vm86 subfunction (%ld)\n", subfunction);
> +        qemu_log_mask(LOG_UNIMP, "qemu: unsupported vm86 subfunction (%ld)\n",
> +                      subfunction);
>          ret = -TARGET_EINVAL;
>          goto out;
>      case TARGET_VM86_PLUS_INSTALL_CHECK:
> 

Reviewed-by: Laurent Vivier <laurent@vivier.eu>

