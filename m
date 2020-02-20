Return-Path: <SRS0=d4IR=4I=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 731B8C11D00
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Feb 2020 09:27:02 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3C98C20801
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Feb 2020 09:27:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3C98C20801
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38484 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j4i6n-0006KY-Dy
	for qemu-devel@archiver.kernel.org; Thu, 20 Feb 2020 04:27:01 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:51905)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <laurent@vivier.eu>) id 1j4i1e-0004JK-Pa
 for qemu-devel@nongnu.org; Thu, 20 Feb 2020 04:21:44 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <laurent@vivier.eu>) id 1j4i1c-0008Ck-89
 for qemu-devel@nongnu.org; Thu, 20 Feb 2020 04:21:42 -0500
Received: from mout.kundenserver.de ([217.72.192.75]:49095)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <laurent@vivier.eu>) id 1j4i1b-0008CA-Q5
 for qemu-devel@nongnu.org; Thu, 20 Feb 2020 04:21:40 -0500
Received: from localhost.localdomain ([78.238.229.36]) by
 mrelayeu.kundenserver.de (mreue107 [212.227.15.183]) with ESMTPSA (Nemesis)
 id 1N49Qd-1jVU5t1cDh-01029T; Thu, 20 Feb 2020 10:21:00 +0100
From: Laurent Vivier <laurent@vivier.eu>
To: qemu-devel@nongnu.org
Subject: [PULL 06/13] linux-user: Use `qemu_log' for non-strace logging
Date: Thu, 20 Feb 2020 10:20:46 +0100
Message-Id: <20200220092053.1510215-7-laurent@vivier.eu>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200220092053.1510215-1-laurent@vivier.eu>
References: <20200220092053.1510215-1-laurent@vivier.eu>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:LUucbHyuMxqamvHNWAt25CFB+/lnMJMChHVX8IvmR3BiHfao2BL
 rxIr3zM94BH1mxgjnCXYV19OicsAl9T9I7PzQu19/7BQ1zLSp5TMX78QUTXGAJ8xBfDdv5l
 aDlgbzB98P/nun7aIDxzWeMJKqY++iRGA97HrEnD+Q0L8S9AfDIWPisivCZEtR2P4UOQOZu
 ffXxdX1wQuUMAD7bcaOSQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:OqxRaGxqUf0=:R2fXmGpD5V0cSKx0/9ZmnW
 fIYuozdPzBHNbKULhxylzs/sFhhH+HYDccPQh9HlZ64MWxTehlU1m321PStuMyKn8NiO1u0nL
 4ocezJ+X7HqZxjJ6P6IAi4Z6x5fqhrQwg9NHSNLWj0is7t7y/UUJ5QKCytTM6jrh3t/YGNFIs
 Tj2RMS6eEdJ/gZoRJilKnJiG0Ozxc6rlPGFN2Ms0un+cDldGUwy+gA17/AzDWSFkr1YNWVweu
 4WAYx/2wE3uEg+TjNGpVmvsDpfVtmoqR0Xd9rl04bq7iDLdJr+JJBOdPU2YawrwM0sc/wm5rX
 356NcbXAnW0jMQj/trZ2CJBIGrceWr6YNeXSkdnqmOmPDy652ROgXQXP9nFB/+KWcIA1pKR9J
 YAAMXargxDVG3MMK7A/cqXic+8eHLFt3OeONZYI9np8H/oGV9/Ex+QDYCruNpAJDjzfQ19Ae4
 /9Bt9fhkWN5sK4+gbjyz3mOzNFWwkCvCbhd2PNr0oua48X4JVf2t7THPPX/poHqLA1anIJtiU
 6uKyDTmkCAcDmLc4VeIJtTiIDuoGWuwFGk0yNOi8SyTu1YJg61f3eGhWEv43QbAl7Bg0O32Rz
 CdFKjrEfl/jeuwyDXbsRKp6uNlu+zDuyCA/VZlJlIvc+RE8Xt9vJ/TM2NoK0I4i5PIGAJjEXZ
 +Y/YRgXVdHJIngELPWKhgGMre052PrMQ5XI2x6mgH8F6H/SfAqFQ5RmvGRtY4xZl3ud1I5fDc
 3Q7tgQFyNy7umSK+cpOQLQFiceFFrM6eSMGGWTduapCE3elhQoLDOvlH0MnEvfNpcWJfHeTTi
 W4ZgLnDDodt2HkcxeFH4NufY0byKJbxi74aBOrcY58O26f3AYth3yCxrGAQ4cEXpJwAa4Jw
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 217.72.192.75
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
Cc: Riku Voipio <riku.voipio@iki.fi>, Laurent Vivier <laurent@vivier.eu>,
 Josh Kunz <jkz@google.com>, Aleksandar Markovic <amarkovic@wavecomp.com>,
 Aleksandar Rikalo <aleksandar.rikalo@rt-rk.com>,
 Aurelien Jarno <aurelien@aurel32.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Josh Kunz <jkz@google.com>

Since most calls to `gemu_log` are actually logging unimplemented features,
this change replaces most non-strace calls to `gemu_log` with calls to
`qemu_log_mask(LOG_UNIMP, ...)`.  This allows the user to easily log to
a file, and to mask out these log messages if they desire.

Note: This change is slightly backwards incompatible, since now these
"unimplemented" log messages will not be logged by default.

Signed-off-by: Josh Kunz <jkz@google.com>
Reviewed-by: Laurent Vivier <laurent@vivier.eu>
Message-Id: <20200204025416.111409-2-jkz@google.com>
Signed-off-by: Laurent Vivier <laurent@vivier.eu>
---
 linux-user/arm/cpu_loop.c |  5 ++--
 linux-user/fd-trans.c     | 55 +++++++++++++++++++++++++--------------
 linux-user/syscall.c      | 35 ++++++++++++++++---------
 linux-user/vm86.c         |  3 ++-
 4 files changed, 62 insertions(+), 36 deletions(-)

diff --git a/linux-user/arm/cpu_loop.c b/linux-user/arm/cpu_loop.c
index 1fae90c6dfc6..cf618daa1ca5 100644
--- a/linux-user/arm/cpu_loop.c
+++ b/linux-user/arm/cpu_loop.c
@@ -349,8 +349,9 @@ void cpu_loop(CPUARMState *env)
                             env->regs[0] = cpu_get_tls(env);
                             break;
                         default:
-                            gemu_log("qemu: Unsupported ARM syscall: 0x%x\n",
-                                     n);
+                            qemu_log_mask(LOG_UNIMP,
+                                          "qemu: Unsupported ARM syscall: 0x%x\n",
+                                          n);
                             env->regs[0] = -TARGET_ENOSYS;
                             break;
                         }
diff --git a/linux-user/fd-trans.c b/linux-user/fd-trans.c
index 9b92386abf51..c0687c52e62b 100644
--- a/linux-user/fd-trans.c
+++ b/linux-user/fd-trans.c
@@ -514,7 +514,8 @@ static abi_long host_to_target_data_bridge_nlattr(struct nlattr *nlattr,
         u32[1] = tswap32(u32[1]); /* optmask */
         break;
     default:
-        gemu_log("Unknown QEMU_IFLA_BR type %d\n", nlattr->nla_type);
+        qemu_log_mask(LOG_UNIMP, "Unknown QEMU_IFLA_BR type %d\n",
+                      nlattr->nla_type);
         break;
     }
     return 0;
@@ -577,7 +578,8 @@ static abi_long host_to_target_slave_data_bridge_nlattr(struct nlattr *nlattr,
     case QEMU_IFLA_BRPORT_BRIDGE_ID:
         break;
     default:
-        gemu_log("Unknown QEMU_IFLA_BRPORT type %d\n", nlattr->nla_type);
+        qemu_log_mask(LOG_UNIMP, "Unknown QEMU_IFLA_BRPORT type %d\n",
+                      nlattr->nla_type);
         break;
     }
     return 0;
@@ -605,7 +607,8 @@ static abi_long host_to_target_data_tun_nlattr(struct nlattr *nlattr,
         *u32 = tswap32(*u32);
         break;
     default:
-        gemu_log("Unknown QEMU_IFLA_TUN type %d\n", nlattr->nla_type);
+        qemu_log_mask(LOG_UNIMP, "Unknown QEMU_IFLA_TUN type %d\n",
+                      nlattr->nla_type);
         break;
     }
     return 0;
@@ -652,7 +655,8 @@ static abi_long host_to_target_data_linkinfo_nlattr(struct nlattr *nlattr,
                                                   NULL,
                                                 host_to_target_data_tun_nlattr);
         } else {
-            gemu_log("Unknown QEMU_IFLA_INFO_KIND %s\n", li_context->name);
+            qemu_log_mask(LOG_UNIMP, "Unknown QEMU_IFLA_INFO_KIND %s\n",
+                          li_context->name);
         }
         break;
     case QEMU_IFLA_INFO_SLAVE_DATA:
@@ -663,12 +667,13 @@ static abi_long host_to_target_data_linkinfo_nlattr(struct nlattr *nlattr,
                                                   NULL,
                                        host_to_target_slave_data_bridge_nlattr);
         } else {
-            gemu_log("Unknown QEMU_IFLA_INFO_SLAVE_KIND %s\n",
+            qemu_log_mask(LOG_UNIMP, "Unknown QEMU_IFLA_INFO_SLAVE_KIND %s\n",
                      li_context->slave_name);
         }
         break;
     default:
-        gemu_log("Unknown host QEMU_IFLA_INFO type: %d\n", nlattr->nla_type);
+        qemu_log_mask(LOG_UNIMP, "Unknown host QEMU_IFLA_INFO type: %d\n",
+                      nlattr->nla_type);
         break;
     }
 
@@ -690,7 +695,8 @@ static abi_long host_to_target_data_inet_nlattr(struct nlattr *nlattr,
         }
         break;
     default:
-        gemu_log("Unknown host AF_INET type: %d\n", nlattr->nla_type);
+        qemu_log_mask(LOG_UNIMP, "Unknown host AF_INET type: %d\n",
+                      nlattr->nla_type);
     }
     return 0;
 }
@@ -741,7 +747,8 @@ static abi_long host_to_target_data_inet6_nlattr(struct nlattr *nlattr,
         }
         break;
     default:
-        gemu_log("Unknown host AF_INET6 type: %d\n", nlattr->nla_type);
+        qemu_log_mask(LOG_UNIMP, "Unknown host AF_INET6 type: %d\n",
+                      nlattr->nla_type);
     }
     return 0;
 }
@@ -759,7 +766,8 @@ static abi_long host_to_target_data_spec_nlattr(struct nlattr *nlattr,
                                               NULL,
                                              host_to_target_data_inet6_nlattr);
     default:
-        gemu_log("Unknown host AF_SPEC type: %d\n", nlattr->nla_type);
+        qemu_log_mask(LOG_UNIMP, "Unknown host AF_SPEC type: %d\n",
+                      nlattr->nla_type);
         break;
     }
     return 0;
@@ -780,7 +788,8 @@ static abi_long host_to_target_data_xdp_nlattr(struct nlattr *nlattr,
         *u32 = tswap32(*u32);
         break;
     default:
-        gemu_log("Unknown host XDP type: %d\n", nlattr->nla_type);
+        qemu_log_mask(
+            LOG_UNIMP, "Unknown host XDP type: %d\n", nlattr->nla_type);
         break;
     }
     return 0;
@@ -920,7 +929,8 @@ static abi_long host_to_target_data_link_rtattr(struct rtattr *rtattr)
                                               NULL,
                                                 host_to_target_data_xdp_nlattr);
     default:
-        gemu_log("Unknown host QEMU_IFLA type: %d\n", rtattr->rta_type);
+        qemu_log_mask(LOG_UNIMP, "Unknown host QEMU_IFLA type: %d\n",
+                      rtattr->rta_type);
         break;
     }
     return 0;
@@ -954,7 +964,8 @@ static abi_long host_to_target_data_addr_rtattr(struct rtattr *rtattr)
         ci->tstamp = tswap32(ci->tstamp);
         break;
     default:
-        gemu_log("Unknown host IFA type: %d\n", rtattr->rta_type);
+        qemu_log_mask(
+            LOG_UNIMP, "Unknown host IFA type: %d\n", rtattr->rta_type);
         break;
     }
     return 0;
@@ -996,7 +1007,8 @@ static abi_long host_to_target_data_route_rtattr(struct rtattr *rtattr)
 #endif
         break;
     default:
-        gemu_log("Unknown host RTA type: %d\n", rtattr->rta_type);
+        qemu_log_mask(
+            LOG_UNIMP, "Unknown host RTA type: %d\n", rtattr->rta_type);
         break;
     }
     return 0;
@@ -1111,7 +1123,8 @@ static abi_long target_to_host_data_link_rtattr(struct rtattr *rtattr)
 {
     switch (rtattr->rta_type) {
     default:
-        gemu_log("Unknown target QEMU_IFLA type: %d\n", rtattr->rta_type);
+        qemu_log_mask(LOG_UNIMP, "Unknown target QEMU_IFLA type: %d\n",
+                      rtattr->rta_type);
         break;
     }
     return 0;
@@ -1125,7 +1138,8 @@ static abi_long target_to_host_data_addr_rtattr(struct rtattr *rtattr)
     case IFA_ADDRESS:
         break;
     default:
-        gemu_log("Unknown target IFA type: %d\n", rtattr->rta_type);
+        qemu_log_mask(LOG_UNIMP, "Unknown target IFA type: %d\n",
+                      rtattr->rta_type);
         break;
     }
     return 0;
@@ -1147,7 +1161,8 @@ static abi_long target_to_host_data_route_rtattr(struct rtattr *rtattr)
         *u32 = tswap32(*u32);
         break;
     default:
-        gemu_log("Unknown target RTA type: %d\n", rtattr->rta_type);
+        qemu_log_mask(LOG_UNIMP, "Unknown target RTA type: %d\n",
+                      rtattr->rta_type);
         break;
     }
     return 0;
@@ -1232,8 +1247,8 @@ static abi_long host_to_target_data_audit(struct nlmsghdr *nlh)
 {
     switch (nlh->nlmsg_type) {
     default:
-        gemu_log("Unknown host audit message type %d\n",
-                 nlh->nlmsg_type);
+        qemu_log_mask(LOG_UNIMP, "Unknown host audit message type %d\n",
+                      nlh->nlmsg_type);
         return -TARGET_EINVAL;
     }
     return 0;
@@ -1253,8 +1268,8 @@ static abi_long target_to_host_data_audit(struct nlmsghdr *nlh)
     case AUDIT_FIRST_USER_MSG2 ... AUDIT_LAST_USER_MSG2:
         break;
     default:
-        gemu_log("Unknown target audit message type %d\n",
-                 nlh->nlmsg_type);
+        qemu_log_mask(LOG_UNIMP, "Unknown target audit message type %d\n",
+                      nlh->nlmsg_type);
         return -TARGET_EINVAL;
     }
 
diff --git a/linux-user/syscall.c b/linux-user/syscall.c
index 9fa722f2388d..16d98c1ff5ff 100644
--- a/linux-user/syscall.c
+++ b/linux-user/syscall.c
@@ -1563,7 +1563,11 @@ static inline abi_long target_to_host_cmsg(struct msghdr *msgh,
              * something more intelligent than "twice the size of the
              * target buffer we're reading from".
              */
-            gemu_log("Host cmsg overflow\n");
+            qemu_log_mask(LOG_UNIMP,
+                          ("Unsupported ancillary data %d/%d: "
+                           "unhandled msg size\n"),
+                          tswap32(target_cmsg->cmsg_level),
+                          tswap32(target_cmsg->cmsg_type));
             break;
         }
 
@@ -1593,8 +1597,8 @@ static inline abi_long target_to_host_cmsg(struct msghdr *msgh,
             __get_user(cred->uid, &target_cred->uid);
             __get_user(cred->gid, &target_cred->gid);
         } else {
-            gemu_log("Unsupported ancillary data: %d/%d\n",
-                                        cmsg->cmsg_level, cmsg->cmsg_type);
+            qemu_log_mask(LOG_UNIMP, "Unsupported ancillary data: %d/%d\n",
+                          cmsg->cmsg_level, cmsg->cmsg_type);
             memcpy(data, target_data, len);
         }
 
@@ -1815,8 +1819,8 @@ static inline abi_long host_to_target_cmsg(struct target_msghdr *target_msgh,
 
         default:
         unimplemented:
-            gemu_log("Unsupported ancillary data: %d/%d\n",
-                                        cmsg->cmsg_level, cmsg->cmsg_type);
+            qemu_log_mask(LOG_UNIMP, "Unsupported ancillary data: %d/%d\n",
+                          cmsg->cmsg_level, cmsg->cmsg_type);
             memcpy(target_data, data, MIN(len, tgt_len));
             if (tgt_len > len) {
                 memset(target_data + len, 0, tgt_len - len);
@@ -2291,7 +2295,8 @@ set_timeout:
 #endif /* SOL_NETLINK */
     default:
     unimplemented:
-        gemu_log("Unsupported setsockopt level=%d optname=%d\n", level, optname);
+        qemu_log_mask(LOG_UNIMP, "Unsupported setsockopt level=%d optname=%d\n",
+                      level, optname);
         ret = -TARGET_ENOPROTOOPT;
     }
     return ret;
@@ -2698,8 +2703,9 @@ get_timeout:
 #endif /* SOL_NETLINK */
     default:
     unimplemented:
-        gemu_log("getsockopt level=%d optname=%d not yet supported\n",
-                 level, optname);
+        qemu_log_mask(LOG_UNIMP,
+                      "getsockopt level=%d optname=%d not yet supported\n",
+                      level, optname);
         ret = -TARGET_EOPNOTSUPP;
         break;
     }
@@ -3454,7 +3460,7 @@ static abi_long do_socketcall(int num, abi_ulong vptr)
     case TARGET_SYS_SENDMMSG: /* sockfd, msgvec, vlen, flags */
         return do_sendrecvmmsg(a[0], a[1], a[2], a[3], 1);
     default:
-        gemu_log("Unsupported socketcall: %d\n", num);
+        qemu_log_mask(LOG_UNIMP, "Unsupported socketcall: %d\n", num);
         return -TARGET_EINVAL;
     }
 }
@@ -4365,7 +4371,8 @@ static abi_long do_ipc(CPUArchState *cpu_env,
         ret = do_shmctl(first, second, ptr);
         break;
     default:
-	gemu_log("Unsupported ipc call: %d (version %d)\n", call, version);
+        qemu_log_mask(LOG_UNIMP, "Unsupported ipc call: %d (version %d)\n",
+                      call, version);
 	ret = -TARGET_ENOSYS;
 	break;
     }
@@ -5213,7 +5220,8 @@ static abi_long do_ioctl(int fd, int cmd, abi_long arg)
     ie = ioctl_entries;
     for(;;) {
         if (ie->target_cmd == 0) {
-            gemu_log("Unsupported ioctl: cmd=0x%04lx\n", (long)cmd);
+            qemu_log_mask(
+                LOG_UNIMP, "Unsupported ioctl: cmd=0x%04lx\n", (long)cmd);
             return -TARGET_ENOSYS;
         }
         if (ie->target_cmd == cmd)
@@ -5281,8 +5289,9 @@ static abi_long do_ioctl(int fd, int cmd, abi_long arg)
         }
         break;
     default:
-        gemu_log("Unsupported ioctl type: cmd=0x%04lx type=%d\n",
-                 (long)cmd, arg_type[0]);
+        qemu_log_mask(LOG_UNIMP,
+                      "Unsupported ioctl type: cmd=0x%04lx type=%d\n",
+                      (long)cmd, arg_type[0]);
         ret = -TARGET_ENOSYS;
         break;
     }
diff --git a/linux-user/vm86.c b/linux-user/vm86.c
index 2fa7a89edc4e..4412522c4c4e 100644
--- a/linux-user/vm86.c
+++ b/linux-user/vm86.c
@@ -402,7 +402,8 @@ int do_vm86(CPUX86State *env, long subfunction, abi_ulong vm86_addr)
     case TARGET_VM86_FREE_IRQ:
     case TARGET_VM86_GET_IRQ_BITS:
     case TARGET_VM86_GET_AND_RESET_IRQ:
-        gemu_log("qemu: unsupported vm86 subfunction (%ld)\n", subfunction);
+        qemu_log_mask(LOG_UNIMP, "qemu: unsupported vm86 subfunction (%ld)\n",
+                      subfunction);
         ret = -TARGET_EINVAL;
         goto out;
     case TARGET_VM86_PLUS_INSTALL_CHECK:
-- 
2.24.1


