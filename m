Return-Path: <SRS0=7MIY=3D=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC70FC33CA9
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Jan 2020 03:05:05 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 84FA32084D
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Jan 2020 03:05:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="e/PcRYD0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 84FA32084D
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58642 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1irCVs-0007k5-HY
	for qemu-devel@archiver.kernel.org; Mon, 13 Jan 2020 22:05:04 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:54205)
 by lists.gnu.org with esmtp (Exim 4.90_1) (envelope-from
 <3Pi8dXgMKCgkst8pxxpun.lxvznv3-mn4nuwxwpw3.x0p@flex--jkz.bounces.google.com>)
 id 1irCTL-0004la-1M
 for qemu-devel@nongnu.org; Mon, 13 Jan 2020 22:02:29 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from
 <3Pi8dXgMKCgkst8pxxpun.lxvznv3-mn4nuwxwpw3.x0p@flex--jkz.bounces.google.com>)
 id 1irCTI-0000r8-RL
 for qemu-devel@nongnu.org; Mon, 13 Jan 2020 22:02:26 -0500
Received: from mail-pg1-x549.google.com ([2607:f8b0:4864:20::549]:51395)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from
 <3Pi8dXgMKCgkst8pxxpun.lxvznv3-mn4nuwxwpw3.x0p@flex--jkz.bounces.google.com>)
 id 1irCTI-0000p4-It
 for qemu-devel@nongnu.org; Mon, 13 Jan 2020 22:02:24 -0500
Received: by mail-pg1-x549.google.com with SMTP id g20so7622621pgb.18
 for <qemu-devel@nongnu.org>; Mon, 13 Jan 2020 19:02:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20161025;
 h=date:in-reply-to:message-id:mime-version:references:subject:from:to
 :cc; bh=cGEohipzmDy9kQUhQkmw2CcILJXai0UI7mjRYvuc/t8=;
 b=e/PcRYD0Lm8zBlayLqkCV7H561EbbZYxHbEhaEIjgy/5F8QjMHHmHv1rTQi7lbeQ9a
 QATCZ+IGRMS6zIn8FhOkerjia4h9h7gODe9M1djbBebgJxj1FVDAss7Ir2szsVvOFdWC
 OpIkQSrchp73Smh+X7cBhigKvCQp9c+69zLZwwH1zG/WFesVFpjXGtswcEuLMSyqS/zV
 OT3KqDgB2D1EiGCkT6SuQjGAew4YvWF/uu/fwdCPiKJr9a+bwfyC3AsezUK3sqSAFZVn
 M7K9gm2aU4Vwl9g4K2ER673HwzjWS9B//TWeSOtBiM4/WHf12afhgiVo+/N/OEYo2w0k
 Bxxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:in-reply-to:message-id:mime-version
 :references:subject:from:to:cc;
 bh=cGEohipzmDy9kQUhQkmw2CcILJXai0UI7mjRYvuc/t8=;
 b=NObEWqXBQZICPtdZwVVs2+GQDYkR7rzWSaHq7+L4uRu5w09t7UBYfG/vHFceGNcWsL
 hM05+VkwQuTsypKw5wDhmzalkry8dJM0bH9eQr9fgH2G6VnILnC6uhzTJjuFKdRFy2Sh
 l0w/oVYSuVcdhsz8BWqeEYC9YhHZ6PaL9DqI6E3ho1oK425Lj5spQnqpyxjxFgKNdDwm
 4VtTNk/U+L4GMxLK7p7U21XSuxnNZ8eVF0mjAkDQtlj1xU2+msvh+he7reIIUkT+Yl0+
 jgje/APGvfEuCB9xObiyH/MhzFXe/T6H40UM/ZnqgSQ8K3P+9tnlMaAecEtb3eIqCfAU
 EXBg==
X-Gm-Message-State: APjAAAUe0Ai/issQbywFSLtIPo0kkhRadFuvGNfS//l2eQdZaQwJYWdk
 Ppg6TTynYjL5HbAbP8LbzXM2Mme2EBIqtPx0am2yR+Bx9dSaXle2Q9hlr5Uw3KwmbjPf/eo/uT3
 b4MpXfEspZRH3npBJd7fW04dkIPofQakHVcu0pJgVNHcuxyKK4+zW
X-Google-Smtp-Source: APXvYqz2N6e+EVm9WFXWfR5nFMYPU/+cQvxRzBuTUauTHC7gr4a6GcsXs6om9j+uRnGC88TrLmsZ/+w=
X-Received: by 2002:a63:710:: with SMTP id 16mr24220851pgh.58.1578970942586;
 Mon, 13 Jan 2020 19:02:22 -0800 (PST)
Date: Mon, 13 Jan 2020 19:01:35 -0800
In-Reply-To: <20200114030138.260347-1-jkz@google.com>
Message-Id: <20200114030138.260347-2-jkz@google.com>
Mime-Version: 1.0
References: <20200114030138.260347-1-jkz@google.com>
X-Mailer: git-send-email 2.25.0.rc1.283.g88dfdc4193-goog
Subject: [PATCH 1/4] linux-user: Use `qemu_log' for non-strace logging
From: Josh Kunz <jkz@google.com>
To: qemu-devel@nongnu.org
Cc: riku.voipio@iki.fi, laurent@vivier.eu, alex.bennee@linaro.org, 
 armbru@redhat.com, Josh Kunz <jkz@google.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::549
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

This change introduces a new logging mask "LOG_USER", which is used for
masking general user-mode logging. This change also switches all non-strace
uses of `gemu_log' in linux-user/ to use `qemu_log_mask(LOG_USER, ...)'
instead. This allows the user to easily log to a file, and to mask out
these log messages if they desire.

Signed-off-by: Josh Kunz <jkz@google.com>
---
 include/qemu/log.h        |  2 ++
 linux-user/arm/cpu_loop.c |  5 ++--
 linux-user/fd-trans.c     | 55 +++++++++++++++++++++++++--------------
 linux-user/main.c         | 24 +++++++++++++++++
 linux-user/syscall.c      | 30 ++++++++++++---------
 linux-user/vm86.c         |  3 ++-
 util/log.c                |  3 +++
 7 files changed, 86 insertions(+), 36 deletions(-)

diff --git a/include/qemu/log.h b/include/qemu/log.h
index e0f4e40628..503e4f88d5 100644
--- a/include/qemu/log.h
+++ b/include/qemu/log.h
@@ -62,6 +62,8 @@ static inline bool qemu_log_separate(void)
 #define CPU_LOG_TB_OP_IND  (1 << 16)
 #define CPU_LOG_TB_FPU     (1 << 17)
 #define CPU_LOG_PLUGIN     (1 << 18)
+/* LOG_USER is used for some informational user-mode logging. */
+#define LOG_USER           (1 << 19)
 
 /* Lock output for a series of related logs.  Since this is not needed
  * for a single qemu_log / qemu_log_mask / qemu_log_mask_and_addr, we
diff --git a/linux-user/arm/cpu_loop.c b/linux-user/arm/cpu_loop.c
index 1fae90c6df..830ba8f138 100644
--- a/linux-user/arm/cpu_loop.c
+++ b/linux-user/arm/cpu_loop.c
@@ -349,8 +349,9 @@ void cpu_loop(CPUARMState *env)
                             env->regs[0] = cpu_get_tls(env);
                             break;
                         default:
-                            gemu_log("qemu: Unsupported ARM syscall: 0x%x\n",
-                                     n);
+                            qemu_log_mask(LOG_USER,
+                                          "qemu: Unsupported ARM syscall: 0x%x\n",
+                                          n);
                             env->regs[0] = -TARGET_ENOSYS;
                             break;
                         }
diff --git a/linux-user/fd-trans.c b/linux-user/fd-trans.c
index 9b92386abf..a5324b8a06 100644
--- a/linux-user/fd-trans.c
+++ b/linux-user/fd-trans.c
@@ -514,7 +514,8 @@ static abi_long host_to_target_data_bridge_nlattr(struct nlattr *nlattr,
         u32[1] = tswap32(u32[1]); /* optmask */
         break;
     default:
-        gemu_log("Unknown QEMU_IFLA_BR type %d\n", nlattr->nla_type);
+        qemu_log_mask(LOG_USER, "Unknown QEMU_IFLA_BR type %d\n",
+                      nlattr->nla_type);
         break;
     }
     return 0;
@@ -577,7 +578,8 @@ static abi_long host_to_target_slave_data_bridge_nlattr(struct nlattr *nlattr,
     case QEMU_IFLA_BRPORT_BRIDGE_ID:
         break;
     default:
-        gemu_log("Unknown QEMU_IFLA_BRPORT type %d\n", nlattr->nla_type);
+        qemu_log_mask(LOG_USER, "Unknown QEMU_IFLA_BRPORT type %d\n",
+                      nlattr->nla_type);
         break;
     }
     return 0;
@@ -605,7 +607,8 @@ static abi_long host_to_target_data_tun_nlattr(struct nlattr *nlattr,
         *u32 = tswap32(*u32);
         break;
     default:
-        gemu_log("Unknown QEMU_IFLA_TUN type %d\n", nlattr->nla_type);
+        qemu_log_mask(LOG_USER, "Unknown QEMU_IFLA_TUN type %d\n",
+                      nlattr->nla_type);
         break;
     }
     return 0;
@@ -652,7 +655,8 @@ static abi_long host_to_target_data_linkinfo_nlattr(struct nlattr *nlattr,
                                                   NULL,
                                                 host_to_target_data_tun_nlattr);
         } else {
-            gemu_log("Unknown QEMU_IFLA_INFO_KIND %s\n", li_context->name);
+            qemu_log_mask(LOG_USER, "Unknown QEMU_IFLA_INFO_KIND %s\n",
+                          li_context->name);
         }
         break;
     case QEMU_IFLA_INFO_SLAVE_DATA:
@@ -663,12 +667,13 @@ static abi_long host_to_target_data_linkinfo_nlattr(struct nlattr *nlattr,
                                                   NULL,
                                        host_to_target_slave_data_bridge_nlattr);
         } else {
-            gemu_log("Unknown QEMU_IFLA_INFO_SLAVE_KIND %s\n",
+            qemu_log_mask(LOG_USER, "Unknown QEMU_IFLA_INFO_SLAVE_KIND %s\n",
                      li_context->slave_name);
         }
         break;
     default:
-        gemu_log("Unknown host QEMU_IFLA_INFO type: %d\n", nlattr->nla_type);
+        qemu_log_mask(LOG_USER, "Unknown host QEMU_IFLA_INFO type: %d\n",
+                      nlattr->nla_type);
         break;
     }
 
@@ -690,7 +695,8 @@ static abi_long host_to_target_data_inet_nlattr(struct nlattr *nlattr,
         }
         break;
     default:
-        gemu_log("Unknown host AF_INET type: %d\n", nlattr->nla_type);
+        qemu_log_mask(LOG_USER, "Unknown host AF_INET type: %d\n",
+                      nlattr->nla_type);
     }
     return 0;
 }
@@ -741,7 +747,8 @@ static abi_long host_to_target_data_inet6_nlattr(struct nlattr *nlattr,
         }
         break;
     default:
-        gemu_log("Unknown host AF_INET6 type: %d\n", nlattr->nla_type);
+        qemu_log_mask(LOG_USER, "Unknown host AF_INET6 type: %d\n",
+                      nlattr->nla_type);
     }
     return 0;
 }
@@ -759,7 +766,8 @@ static abi_long host_to_target_data_spec_nlattr(struct nlattr *nlattr,
                                               NULL,
                                              host_to_target_data_inet6_nlattr);
     default:
-        gemu_log("Unknown host AF_SPEC type: %d\n", nlattr->nla_type);
+        qemu_log_mask(LOG_USER, "Unknown host AF_SPEC type: %d\n",
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
+            LOG_USER, "Unknown host XDP type: %d\n", nlattr->nla_type);
         break;
     }
     return 0;
@@ -920,7 +929,8 @@ static abi_long host_to_target_data_link_rtattr(struct rtattr *rtattr)
                                               NULL,
                                                 host_to_target_data_xdp_nlattr);
     default:
-        gemu_log("Unknown host QEMU_IFLA type: %d\n", rtattr->rta_type);
+        qemu_log_mask(LOG_USER, "Unknown host QEMU_IFLA type: %d\n",
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
+            LOG_USER, "Unknown host IFA type: %d\n", rtattr->rta_type);
         break;
     }
     return 0;
@@ -996,7 +1007,8 @@ static abi_long host_to_target_data_route_rtattr(struct rtattr *rtattr)
 #endif
         break;
     default:
-        gemu_log("Unknown host RTA type: %d\n", rtattr->rta_type);
+        qemu_log_mask(
+            LOG_USER, "Unknown host RTA type: %d\n", rtattr->rta_type);
         break;
     }
     return 0;
@@ -1111,7 +1123,8 @@ static abi_long target_to_host_data_link_rtattr(struct rtattr *rtattr)
 {
     switch (rtattr->rta_type) {
     default:
-        gemu_log("Unknown target QEMU_IFLA type: %d\n", rtattr->rta_type);
+        qemu_log_mask(LOG_USER, "Unknown target QEMU_IFLA type: %d\n",
+                      rtattr->rta_type);
         break;
     }
     return 0;
@@ -1125,7 +1138,8 @@ static abi_long target_to_host_data_addr_rtattr(struct rtattr *rtattr)
     case IFA_ADDRESS:
         break;
     default:
-        gemu_log("Unknown target IFA type: %d\n", rtattr->rta_type);
+        qemu_log_mask(LOG_USER, "Unknown target IFA type: %d\n",
+                      rtattr->rta_type);
         break;
     }
     return 0;
@@ -1147,7 +1161,8 @@ static abi_long target_to_host_data_route_rtattr(struct rtattr *rtattr)
         *u32 = tswap32(*u32);
         break;
     default:
-        gemu_log("Unknown target RTA type: %d\n", rtattr->rta_type);
+        qemu_log_mask(LOG_USER, "Unknown target RTA type: %d\n",
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
+        qemu_log_mask(LOG_USER, "Unknown host audit message type %d\n",
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
+        qemu_log_mask(LOG_USER, "Unknown target audit message type %d\n",
+                      nlh->nlmsg_type);
         return -TARGET_EINVAL;
     }
 
diff --git a/linux-user/main.c b/linux-user/main.c
index 8718d03ee2..c4f3de77db 100644
--- a/linux-user/main.c
+++ b/linux-user/main.c
@@ -60,6 +60,9 @@ unsigned long mmap_min_addr;
 unsigned long guest_base;
 int have_guest_base;
 
+/* Used to implement backwards-compatibility for user-mode logging. */
+static bool force_user_mode_logging = true;
+
 /*
  * When running 32-on-64 we should make sure we can fit all of the possible
  * guest address space into a contiguous chunk of virtual host memory.
@@ -399,6 +402,11 @@ static void handle_arg_abi_call0(const char *arg)
 }
 #endif
 
+static void handle_arg_no_force_user_mode_logging(const char *arg)
+{
+    force_user_mode_logging = false;
+}
+
 static QemuPluginList plugins = QTAILQ_HEAD_INITIALIZER(plugins);
 
 #ifdef CONFIG_PLUGIN
@@ -469,6 +477,10 @@ static const struct qemu_argument arg_table[] = {
     {"xtensa-abi-call0", "QEMU_XTENSA_ABI_CALL0", false, handle_arg_abi_call0,
      "",           "assume CALL0 Xtensa ABI"},
 #endif
+    {"no-force-user-mode-logging", "", false,
+      handle_arg_no_force_user_mode_logging,
+      "",          "disable forced user-mode logging, other logging options "
+                   "will be used exactly as provided" },
     {NULL, NULL, false, NULL, NULL, NULL}
 };
 
@@ -661,6 +673,18 @@ int main(int argc, char **argv, char **envp)
 
     optind = parse_args(argc, argv);
 
+    if (force_user_mode_logging) {
+        /*
+         * Backwards Compatibility: gemu_log for non-strace messages was not
+         * configurable, and was always on. Unless the user explicitly disables
+         * forced LOG_USER, force LOG_USER into the mask.
+         */
+        qemu_add_log(LOG_USER);
+    }
+
+    qemu_log_mask(LOG_USER, "--> from user\n");
+    qemu_log_mask(LOG_STRACE, "--> from strace\n");
+
     if (!trace_init_backends()) {
         exit(1);
     }
diff --git a/linux-user/syscall.c b/linux-user/syscall.c
index 171c0caef3..7e23dd6327 100644
--- a/linux-user/syscall.c
+++ b/linux-user/syscall.c
@@ -1555,7 +1555,7 @@ static inline abi_long target_to_host_cmsg(struct msghdr *msgh,
              * something more intelligent than "twice the size of the
              * target buffer we're reading from".
              */
-            gemu_log("Host cmsg overflow\n");
+            qemu_log_mask(LOG_USER, "Host cmsg overflow\n");
             break;
         }
 
@@ -1585,8 +1585,8 @@ static inline abi_long target_to_host_cmsg(struct msghdr *msgh,
             __get_user(cred->uid, &target_cred->uid);
             __get_user(cred->gid, &target_cred->gid);
         } else {
-            gemu_log("Unsupported ancillary data: %d/%d\n",
-                                        cmsg->cmsg_level, cmsg->cmsg_type);
+            qemu_log_mask(LOG_USER, "Unsupported ancillary data: %d/%d\n",
+                          cmsg->cmsg_level, cmsg->cmsg_type);
             memcpy(data, target_data, len);
         }
 
@@ -1807,8 +1807,8 @@ static inline abi_long host_to_target_cmsg(struct target_msghdr *target_msgh,
 
         default:
         unimplemented:
-            gemu_log("Unsupported ancillary data: %d/%d\n",
-                                        cmsg->cmsg_level, cmsg->cmsg_type);
+            qemu_log_mask(LOG_USER, "Unsupported ancillary data: %d/%d\n",
+                          cmsg->cmsg_level, cmsg->cmsg_type);
             memcpy(target_data, data, MIN(len, tgt_len));
             if (tgt_len > len) {
                 memset(target_data + len, 0, tgt_len - len);
@@ -2283,7 +2283,8 @@ set_timeout:
 #endif /* SOL_NETLINK */
     default:
     unimplemented:
-        gemu_log("Unsupported setsockopt level=%d optname=%d\n", level, optname);
+        qemu_log_mask(LOG_USER, "Unsupported setsockopt level=%d optname=%d\n",
+                      level, optname);
         ret = -TARGET_ENOPROTOOPT;
     }
     return ret;
@@ -2636,8 +2637,9 @@ static abi_long do_getsockopt(int sockfd, int level, int optname,
 #endif /* SOL_NETLINK */
     default:
     unimplemented:
-        gemu_log("getsockopt level=%d optname=%d not yet supported\n",
-                 level, optname);
+        qemu_log_mask(LOG_USER,
+                      "getsockopt level=%d optname=%d not yet supported\n",
+                      level, optname);
         ret = -TARGET_EOPNOTSUPP;
         break;
     }
@@ -3392,7 +3394,7 @@ static abi_long do_socketcall(int num, abi_ulong vptr)
     case TARGET_SYS_SENDMMSG: /* sockfd, msgvec, vlen, flags */
         return do_sendrecvmmsg(a[0], a[1], a[2], a[3], 1);
     default:
-        gemu_log("Unsupported socketcall: %d\n", num);
+        qemu_log_mask(LOG_USER, "Unsupported socketcall: %d\n", num);
         return -TARGET_EINVAL;
     }
 }
@@ -4303,7 +4305,8 @@ static abi_long do_ipc(CPUArchState *cpu_env,
         ret = do_shmctl(first, second, ptr);
         break;
     default:
-	gemu_log("Unsupported ipc call: %d (version %d)\n", call, version);
+        qemu_log_mask(LOG_USER, "Unsupported ipc call: %d (version %d)\n",
+                      call, version);
 	ret = -TARGET_ENOSYS;
 	break;
     }
@@ -5151,7 +5154,8 @@ static abi_long do_ioctl(int fd, int cmd, abi_long arg)
     ie = ioctl_entries;
     for(;;) {
         if (ie->target_cmd == 0) {
-            gemu_log("Unsupported ioctl: cmd=0x%04lx\n", (long)cmd);
+            qemu_log_mask(
+                LOG_USER, "Unsupported ioctl: cmd=0x%04lx\n", (long)cmd);
             return -TARGET_ENOSYS;
         }
         if (ie->target_cmd == cmd)
@@ -5217,8 +5221,8 @@ static abi_long do_ioctl(int fd, int cmd, abi_long arg)
         }
         break;
     default:
-        gemu_log("Unsupported ioctl type: cmd=0x%04lx type=%d\n",
-                 (long)cmd, arg_type[0]);
+        qemu_log_mask(LOG_USER, "Unsupported ioctl type: cmd=0x%04lx type=%d\n",
+                      (long)cmd, arg_type[0]);
         ret = -TARGET_ENOSYS;
         break;
     }
diff --git a/linux-user/vm86.c b/linux-user/vm86.c
index 2fa7a89edc..0013fd8368 100644
--- a/linux-user/vm86.c
+++ b/linux-user/vm86.c
@@ -402,7 +402,8 @@ int do_vm86(CPUX86State *env, long subfunction, abi_ulong vm86_addr)
     case TARGET_VM86_FREE_IRQ:
     case TARGET_VM86_GET_IRQ_BITS:
     case TARGET_VM86_GET_AND_RESET_IRQ:
-        gemu_log("qemu: unsupported vm86 subfunction (%ld)\n", subfunction);
+        qemu_log_mask(LOG_USER, "qemu: unsupported vm86 subfunction (%ld)\n",
+                      subfunction);
         ret = -TARGET_EINVAL;
         goto out;
     case TARGET_VM86_PLUS_INSTALL_CHECK:
diff --git a/util/log.c b/util/log.c
index 867264da8d..b14d17fafb 100644
--- a/util/log.c
+++ b/util/log.c
@@ -328,6 +328,9 @@ const QEMULogItem qemu_log_items[] = {
 #ifdef CONFIG_PLUGIN
     { CPU_LOG_PLUGIN, "plugin", "output from TCG plugins\n"},
 #endif
+    { LOG_USER, "user_mode",
+      "log when QEMU encounters errors in the user-mode emulation layer.\n"
+      "For example, when a socket option or syscall is not implemented" },
     { 0, NULL, NULL },
 };
 
-- 
2.25.0.rc1.283.g88dfdc4193-goog


