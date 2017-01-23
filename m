Received: from eggs.gnu.org ([2001:4830:134:3::10]:46601)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1cVUCv-0007lC-Ci
	for qemu-devel@nongnu.org; Sun, 22 Jan 2017 21:18:12 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1cVUCu-0004u9-2w
	for qemu-devel@nongnu.org; Sun, 22 Jan 2017 21:18:09 -0500
Received: from mail-qt0-x241.google.com ([2607:f8b0:400d:c0d::241]:35570)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <rth7680@gmail.com>) id 1cVUCt-0004u3-Um
	for qemu-devel@nongnu.org; Sun, 22 Jan 2017 21:18:08 -0500
Received: by mail-qt0-x241.google.com with SMTP id f4so14077140qte.2
	for <qemu-devel@nongnu.org>; Sun, 22 Jan 2017 18:18:07 -0800 (PST)
Sender: Richard Henderson <rth7680@gmail.com>
From: Richard Henderson <rth@twiddle.net>
Date: Sun, 22 Jan 2017 18:17:33 -0800
Message-Id: <20170123021748.13170-12-rth@twiddle.net>
In-Reply-To: <20170123021748.13170-1-rth@twiddle.net>
References: <20170123021748.13170-1-rth@twiddle.net>
Subject: [Qemu-devel] [PULL 11/26] linux-user: Add HPPA target_syscall.h
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org

Which is primarily a re-definition of errno numbers.

Signed-off-by: Richard Henderson <rth@twiddle.net>
---
 linux-user/hppa/target_syscall.h | 237 +++++++++++++++++++++++++++++++++++++++
 1 file changed, 237 insertions(+)
 create mode 100644 linux-user/hppa/target_syscall.h

diff --git a/linux-user/hppa/target_syscall.h b/linux-user/hppa/target_syscall.h
new file mode 100644
index 0000000..ac18a9c
--- /dev/null
+++ b/linux-user/hppa/target_syscall.h
@@ -0,0 +1,237 @@
+#ifndef HPPA_TARGET_SYSCALL_H
+#define HPPA_TARGET_SYSCALL_H
+
+struct target_pt_regs {
+    target_ulong gr[32];
+    uint64_t     fr[32];
+    target_ulong sr[8];
+    target_ulong iasq[2];
+    target_ulong iaoq[2];
+    target_ulong cr27;
+    target_ulong __pad0;
+    target_ulong orig_r28;
+    target_ulong ksp;
+    target_ulong kpc;
+    target_ulong sar;
+    target_ulong iir;
+    target_ulong isr;
+    target_ulong ior;
+    target_ulong ipsw;
+};
+
+#define UNAME_MACHINE "hppa"
+#define UNAME_MINIMUM_RELEASE "2.6.32"
+#define TARGET_CLONE_BACKWARDS
+#define TARGET_MINSIGSTKSZ       2048
+#define TARGET_MLOCKALL_MCL_CURRENT 1
+#define TARGET_MLOCKALL_MCL_FUTURE  2
+
+#undef  TARGET_ENOMSG
+#define TARGET_ENOMSG          35
+#undef  TARGET_EIDRM
+#define TARGET_EIDRM           36
+#undef  TARGET_ECHRNG
+#define TARGET_ECHRNG          37
+#undef  TARGET_EL2NSYNC
+#define TARGET_EL2NSYNC        38
+#undef  TARGET_EL3HLT
+#define TARGET_EL3HLT          39
+#undef  TARGET_EL3RST
+#define TARGET_EL3RST          40
+#undef  TARGET_ELNRNG
+#define TARGET_ELNRNG          41
+#undef  TARGET_EUNATCH
+#define TARGET_EUNATCH         42
+#undef  TARGET_ENOCSI
+#define TARGET_ENOCSI          43
+#undef  TARGET_EL2HLT
+#define TARGET_EL2HLT          44
+#undef  TARGET_EDEADLK
+#define TARGET_EDEADLK         45
+#undef  TARGET_ENOLCK
+#define TARGET_ENOLCK          46
+#undef  TARGET_EILSEQ
+#define TARGET_EILSEQ          47
+
+#undef  TARGET_ENONET
+#define TARGET_ENONET          50
+#undef  TARGET_ENODATA
+#define TARGET_ENODATA         51
+#undef  TARGET_ETIME
+#define TARGET_ETIME           52
+#undef  TARGET_ENOSR
+#define TARGET_ENOSR           53
+#undef  TARGET_ENOSTR
+#define TARGET_ENOSTR          54
+#undef  TARGET_ENOPKG
+#define TARGET_ENOPKG          55
+
+#undef  TARGET_ENOLINK
+#define TARGET_ENOLINK         57
+#undef  TARGET_EADV
+#define TARGET_EADV            58
+#undef  TARGET_ESRMNT
+#define TARGET_ESRMNT          59
+#undef  TARGET_ECOMM
+#define TARGET_ECOMM           60
+#undef  TARGET_EPROTO
+#define TARGET_EPROTO          61
+
+#undef  TARGET_EMULTIHOP
+#define TARGET_EMULTIHOP       64
+
+#undef  TARGET_EDOTDOT
+#define TARGET_EDOTDOT         66
+#undef  TARGET_EBADMSG
+#define TARGET_EBADMSG         67
+#undef  TARGET_EUSERS
+#define TARGET_EUSERS          68
+#undef  TARGET_EDQUOT
+#define TARGET_EDQUOT          69
+#undef  TARGET_ESTALE
+#define TARGET_ESTALE          70
+#undef  TARGET_EREMOTE
+#define TARGET_EREMOTE         71
+#undef  TARGET_EOVERFLOW
+#define TARGET_EOVERFLOW       72
+
+#undef  TARGET_EBADE
+#define TARGET_EBADE           160
+#undef  TARGET_EBADR
+#define TARGET_EBADR           161
+#undef  TARGET_EXFULL
+#define TARGET_EXFULL          162
+#undef  TARGET_ENOANO
+#define TARGET_ENOANO          163
+#undef  TARGET_EBADRQC
+#define TARGET_EBADRQC         164
+#undef  TARGET_EBADSLT
+#define TARGET_EBADSLT         165
+#undef  TARGET_EBFONT
+#define TARGET_EBFONT          166
+#undef  TARGET_ENOTUNIQ
+#define TARGET_ENOTUNIQ        167
+#undef  TARGET_EBADFD
+#define TARGET_EBADFD          168
+#undef  TARGET_EREMCHG
+#define TARGET_EREMCHG         169
+#undef  TARGET_ELIBACC
+#define TARGET_ELIBACC         170
+#undef  TARGET_ELIBBAD
+#define TARGET_ELIBBAD         171
+#undef  TARGET_ELIBSCN
+#define TARGET_ELIBSCN         172
+#undef  TARGET_ELIBMAX
+#define TARGET_ELIBMAX         173
+#undef  TARGET_ELIBEXEC
+#define TARGET_ELIBEXEC        174
+#undef  TARGET_ERESTART
+#define TARGET_ERESTART        175
+#undef  TARGET_ESTRPIPE
+#define TARGET_ESTRPIPE        176
+#undef  TARGET_EUCLEAN
+#define TARGET_EUCLEAN         177
+#undef  TARGET_ENOTNAM
+#define TARGET_ENOTNAM         178
+#undef  TARGET_ENAVAIL
+#define TARGET_ENAVAIL         179
+#undef  TARGET_EISNAM
+#define TARGET_EISNAM          180
+#undef  TARGET_EREMOTEIO
+#define TARGET_EREMOTEIO       181
+#undef  TARGET_ENOMEDIUM
+#define TARGET_ENOMEDIUM       182
+#undef  TARGET_EMEDIUMTYPE
+#define TARGET_EMEDIUMTYPE     183
+#undef  TARGET_ENOKEY
+#define TARGET_ENOKEY          184
+#undef  TARGET_EKEYEXPIRED
+#define TARGET_EKEYEXPIRED     185
+#undef  TARGET_EKEYREVOKED
+#define TARGET_EKEYREVOKED     186
+#undef  TARGET_EKEYREJECTED
+#define TARGET_EKEYREJECTED    187
+
+/* Never used in linux.  */
+/* #define TARGET_ENOSYM          215 */
+#undef  TARGET_ENOTSOCK
+#define TARGET_ENOTSOCK        216
+#undef  TARGET_EDESTADDRREQ
+#define TARGET_EDESTADDRREQ    217
+#undef  TARGET_EMSGSIZE
+#define TARGET_EMSGSIZE        218
+#undef  TARGET_EPROTOTYPE
+#define TARGET_EPROTOTYPE      219
+#undef  TARGET_ENOPROTOOPT
+#define TARGET_ENOPROTOOPT     220
+#undef  TARGET_EPROTONOSUPPORT
+#define TARGET_EPROTONOSUPPORT 221
+#undef  TARGET_ESOCKTNOSUPPORT
+#define TARGET_ESOCKTNOSUPPORT 222
+#undef  TARGET_EOPNOTSUPP
+#define TARGET_EOPNOTSUPP      223
+#undef  TARGET_EPFNOSUPPORT
+#define TARGET_EPFNOSUPPORT    224
+#undef  TARGET_EAFNOSUPPORT
+#define TARGET_EAFNOSUPPORT    225
+#undef  TARGET_EADDRINUSE
+#define TARGET_EADDRINUSE      226
+#undef  TARGET_EADDRNOTAVAIL
+#define TARGET_EADDRNOTAVAIL   227
+#undef  TARGET_ENETDOWN
+#define TARGET_ENETDOWN        228
+#undef  TARGET_ENETUNREACH
+#define TARGET_ENETUNREACH     229
+#undef  TARGET_ENETRESET
+#define TARGET_ENETRESET       230
+#undef  TARGET_ECONNABORTED
+#define TARGET_ECONNABORTED    231
+#undef  TARGET_ECONNRESET
+#define TARGET_ECONNRESET      232
+#undef  TARGET_ENOBUFS
+#define TARGET_ENOBUFS         233
+#undef  TARGET_EISCONN
+#define TARGET_EISCONN         234
+#undef  TARGET_ENOTCONN
+#define TARGET_ENOTCONN        235
+#undef  TARGET_ESHUTDOWN
+#define TARGET_ESHUTDOWN       236
+#undef  TARGET_ETOOMANYREFS
+#define TARGET_ETOOMANYREFS    237
+#undef  TARGET_ETIMEDOUT
+#define TARGET_ETIMEDOUT       238
+#undef  TARGET_ECONNREFUSED
+#define TARGET_ECONNREFUSED    239
+#define TARGET_EREMOTERELEASE  240
+#undef  TARGET_EHOSTDOWN
+#define TARGET_EHOSTDOWN       241
+#undef  TARGET_EHOSTUNREACH
+#define TARGET_EHOSTUNREACH    242
+
+#undef  TARGET_EALREADY
+#define TARGET_EALREADY        244
+#undef  TARGET_EINPROGRESS
+#define TARGET_EINPROGRESS     245
+#undef  TARGET_ENOTEMPTY
+#define TARGET_ENOTEMPTY       247
+#undef  TARGET_ENAMETOOLONG
+#define TARGET_ENAMETOOLONG    248
+#undef  TARGET_ELOOP
+#define TARGET_ELOOP           249
+#undef  TARGET_ENOSYS
+#define TARGET_ENOSYS          251
+
+#undef  TARGET_ECANCELED
+#define TARGET_ECANCELED       253
+
+#undef  TARGET_EOWNERDEAD
+#define TARGET_EOWNERDEAD      254
+#undef  TARGET_ENOTRECOVERABLE
+#define TARGET_ENOTRECOVERABLE 255
+
+#undef  TARGET_ERFKILL
+#define TARGET_ERFKILL         256
+#undef  TARGET_EHWPOISON
+#define TARGET_EHWPOISON       257
+
+#endif /* HPPA_TARGET_SYSCALL_H */
-- 
2.9.3
