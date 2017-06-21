Received: from eggs.gnu.org ([2001:4830:134:3::10]:49135)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1dNnOU-0007Or-5M
	for qemu-devel@nongnu.org; Wed, 21 Jun 2017 17:42:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1dNnOP-0004qe-62
	for qemu-devel@nongnu.org; Wed, 21 Jun 2017 17:42:34 -0400
Received: from mout.kundenserver.de ([212.227.126.130]:63311)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <laurent@vivier.eu>) id 1dNnOO-0004pj-Rb
	for qemu-devel@nongnu.org; Wed, 21 Jun 2017 17:42:29 -0400
References: <149808112660.640.1288061492384019109@4a9a010726c0>
From: Laurent Vivier <laurent@vivier.eu>
Message-ID: <c7abbfcd-7d4f-46ec-d288-be165b081792@vivier.eu>
Date: Wed, 21 Jun 2017 23:42:08 +0200
MIME-Version: 1.0
In-Reply-To: <149808112660.640.1288061492384019109@4a9a010726c0>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v2] target-m68k,
 linux-user: manage FP registers in ucontext
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: famz@redhat.com, riku.voipio@iki.fi, rth@twiddle.net

This fails because this patch must be applied on top of my last pull
request.

Laurent

> /var/tmp/patchew-tester-tmp-rz35mvuf/src/linux-user/signal.c: In function ‘target_rt_save_fpu_state’:
> /var/tmp/patchew-tester-tmp-rz35mvuf/src/linux-user/signal.c:5687:38: error: request for member ‘d’ in something not a structure or union
>          uint32_t high = env->fregs[i].d.high << 16;
>                                       ^
> In file included from /var/tmp/patchew-tester-tmp-rz35mvuf/src/linux-user/signal.c:24:0:
> /var/tmp/patchew-tester-tmp-rz35mvuf/src/linux-user/signal.c:5689:33: error: request for member ‘d’ in something not a structure or union
>          __put_user(env->fregs[i].d.low,
>                                  ^
> /var/tmp/patchew-tester-tmp-rz35mvuf/src/linux-user/qemu.h:469:16: note: in definition of macro ‘__put_user_e’
>       ((hptr), (x)), (void)0)
>                 ^
> /var/tmp/patchew-tester-tmp-rz35mvuf/src/linux-user/signal.c:5689:9: note: in expansion of macro ‘__put_user’
>          __put_user(env->fregs[i].d.low,
>          ^~~~~~~~~~
> /var/tmp/patchew-tester-tmp-rz35mvuf/src/linux-user/qemu.h:469:19: error: left-hand operand of comma expression has no effect [-Werror=unused-value]
>       ((hptr), (x)), (void)0)
>                    ^
> /var/tmp/patchew-tester-tmp-rz35mvuf/src/linux-user/qemu.h:480:31: note: in expansion of macro ‘__put_user_e’
>  # define __put_user(x, hptr)  __put_user_e(x, hptr, be)
>                                ^~~~~~~~~~~~
> /var/tmp/patchew-tester-tmp-rz35mvuf/src/linux-user/signal.c:5689:9: note: in expansion of macro ‘__put_user’
>          __put_user(env->fregs[i].d.low,
>          ^~~~~~~~~~
> /var/tmp/patchew-tester-tmp-rz35mvuf/src/linux-user/signal.c: In function ‘target_rt_restore_fpu_state’:
> /var/tmp/patchew-tester-tmp-rz35mvuf/src/linux-user/signal.c:5733:5: error: implicit declaration of function ‘cpu_m68k_set_fpcr’ [-Werror=implicit-function-declaration]
>      cpu_m68k_set_fpcr(env, fpcr);
>      ^~~~~~~~~~~~~~~~~
> /var/tmp/patchew-tester-tmp-rz35mvuf/src/linux-user/signal.c:5733:5: error: nested extern declaration of ‘cpu_m68k_set_fpcr’ [-Werror=nested-externs]
> /var/tmp/patchew-tester-tmp-rz35mvuf/src/linux-user/signal.c:5740:22: error: request for member ‘d’ in something not a structure or union
>          env->fregs[i].d.high = high >> 16;
>                       ^
> In file included from /var/tmp/patchew-tester-tmp-rz35mvuf/src/linux-user/signal.c:24:0:
> /var/tmp/patchew-tester-tmp-rz35mvuf/src/linux-user/signal.c:5741:33: error: request for member ‘d’ in something not a structure or union
>          __get_user(env->fregs[i].d.low,
>                                  ^
> /var/tmp/patchew-tester-tmp-rz35mvuf/src/linux-user/qemu.h:472:5: note: in definition of macro ‘__get_user_e’
>    ((x) = (typeof(*hptr))(                                               \
>      ^
> /var/tmp/patchew-tester-tmp-rz35mvuf/src/linux-user/signal.c:5741:9: note: in expansion of macro ‘__get_user’
>          __get_user(env->fregs[i].d.low,
>          ^~~~~~~~~~
> /var/tmp/patchew-tester-tmp-rz35mvuf/src/linux-user/qemu.h:477:13: error: left-hand operand of comma expression has no effect [-Werror=unused-value]
>       (hptr)), (void)0)
>              ^
> /var/tmp/patchew-tester-tmp-rz35mvuf/src/linux-user/qemu.h:481:31: note: in expansion of macro ‘__get_user_e’
>  # define __get_user(x, hptr)  __get_user_e(x, hptr, be)
>                                ^~~~~~~~~~~~
> /var/tmp/patchew-tester-tmp-rz35mvuf/src/linux-user/signal.c:5741:9: note: in expansion of macro ‘__get_user’
>          __get_user(env->fregs[i].d.low,
>          ^~~~~~~~~~
> cc1: all warnings being treated as errors
> /var/tmp/patchew-tester-tmp-rz35mvuf/src/rules.mak:66: recipe for target 'linux-user/signal.o' failed
> make[1]: *** [linux-user/signal.o] Error 1
> make[1]: *** Waiting for unfinished jobs....
