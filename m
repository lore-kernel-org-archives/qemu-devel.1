Received: from eggs.gnu.org ([2001:4830:134:3::10]:35238)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1ejoyb-000667-CN
	for qemu-devel@nongnu.org; Thu, 08 Feb 2018 11:23:10 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1ejoya-0004CQ-4U
	for qemu-devel@nongnu.org; Thu, 08 Feb 2018 11:23:09 -0500
Received: from mail-oi0-x22c.google.com ([2607:f8b0:4003:c06::22c]:34651)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1ejoyZ-0004Bj-UM
	for qemu-devel@nongnu.org; Thu, 08 Feb 2018 11:23:08 -0500
Received: by mail-oi0-x22c.google.com with SMTP id k15so3895025oib.1
	for <qemu-devel@nongnu.org>; Thu, 08 Feb 2018 08:23:07 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20180208051601.12800-1-armbru@redhat.com>
References: <20180208051601.12800-1-armbru@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 8 Feb 2018 16:22:46 +0000
Message-ID: <CAFEAcA9L8HK-9Gi5Ug4xHNYtfj1E3E4ttgzFSU7LVESZDnwa6w@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PULL v2 00/20] Miscellaneous patches for
 2018-02-07
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>

2018-02-08 5:16 GMT+00:00 Markus Armbruster <armbru@redhat.com>:
> The following changes since commit 20e0d439a6ded635ec89f6135c08cd5541c689=
62:
>
>   Merge remote-tracking branch 'remotes/rth/tags/pull-hppa-20180204' into=
 staging (2018-02-06 14:21:41 +0000)
>
> are available in the git repository at:
>
>   git://repo.or.cz/qemu/armbru.git tags/pull-misc-2018-02-07-v2
>
> for you to fetch changes up to 2416be0431db85663d69d58824b26618470786dc:
>
>   Move include qemu/option.h from qemu-common.h to actual users (2018-02-=
08 06:12:45 +0100)
>
> ----------------------------------------------------------------
> Miscellaneous patches for 2018-02-07

Build failures everywhere in nvme.c:


/home/pm215/qemu/block/nvme.c:118:1: error: variable =E2=80=98runtime_opts=
=E2=80=99
has initializer but incomplete type
 static QemuOptsList runtime_opts =3D {
 ^
/home/pm215/qemu/block/nvme.c:119:5: error: unknown field =E2=80=98name=E2=
=80=99
specified in initializer
     .name =3D "nvme",
     ^
/home/pm215/qemu/block/nvme.c:119:5: error: excess elements in struct
initializer [-Werror]
/home/pm215/qemu/block/nvme.c:119:5: error: (near initialization for
=E2=80=98runtime_opts=E2=80=99) [-Werror]
/home/pm215/qemu/block/nvme.c:120:5: error: unknown field =E2=80=98head=E2=
=80=99
specified in initializer
     .head =3D QTAILQ_HEAD_INITIALIZER(runtime_opts.head),
     ^
/home/pm215/qemu/block/nvme.c:120:5: error: extra brace group at end
of initializer
[snip huge pile of other probably run-on warnings]

and also on OSX:

/Users/pm215/src/qemu-for-merges/ui/cocoa.m:256:49: error: implicit
declaration of function 'error_get_pretty' is invalid in C99
[-Werror,-Wimplicit-function-declaration]
        QEMU_Alert([NSString stringWithCString: error_get_pretty(err)
                                                ^
/Users/pm215/src/qemu-for-merges/ui/cocoa.m:256:49: error:
incompatible integer to pointer conversion sending 'int' to parameter
of type 'const char * _Nonnull' [-Werror,-Wint-conversion]
        QEMU_Alert([NSString stringWithCString: error_get_pretty(err)
                                                ^~~~~~~~~~~~~~~~~~~~~
/Applications/Xcode.app/Contents/Developer/Platforms/MacOSX.platform/Develo=
per/SDKs/MacOSX10.11.sdk/System/Library/Frameworks/Foundation.framework/Hea=
ders/NSString.h:350:58:
note: passing argument to parameter 'cString' here
+ (nullable instancetype)stringWithCString:(const char *)cString
encoding:(NSStringEncoding)enc;
                                                         ^
/Users/pm215/src/qemu-for-merges/ui/cocoa.m:258:9: error: implicit
declaration of function 'error_free' is invalid in C99
[-Werror,-Wimplicit-function-declaration]
        error_free(err);
        ^
/Users/pm215/src/qemu-for-merges/ui/cocoa.m:258:9: note: did you mean
'g_error_free'?
/sw/include/glib-2.0/glib/gerror.h:56:10: note: 'g_error_free' declared her=
e
void     g_error_free          (GError        *error);
         ^
/Users/pm215/src/qemu-for-merges/ui/cocoa.m:1134:5: error: implicit
declaration of function 'qmp_stop' is invalid in C99
[-Werror,-Wimplicit-function-declaration]
    qmp_stop(NULL);
    ^
/Users/pm215/src/qemu-for-merges/ui/cocoa.m:1134:5: note: did you mean
'vm_stop'?
/Users/pm215/src/qemu-for-merges/include/sysemu/sysemu.h:56:5: note:
'vm_stop' declared here
int vm_stop(RunState state);
    ^
/Users/pm215/src/qemu-for-merges/ui/cocoa.m:1143:5: error: implicit
declaration of function 'qmp_cont' is invalid in C99
[-Werror,-Wimplicit-function-declaration]
    qmp_cont(NULL);
    ^
/Users/pm215/src/qemu-for-merges/ui/cocoa.m:1171:5: error: implicit
declaration of function 'qmp_system_reset' is invalid in C99
[-Werror,-Wimplicit-function-declaration]
    qmp_system_reset(NULL);
    ^
/Users/pm215/src/qemu-for-merges/ui/cocoa.m:1171:5: note: did you mean
'qemu_system_reset'?
/Users/pm215/src/qemu-for-merges/include/sysemu/sysemu.h:83:6: note:
'qemu_system_reset' declared here
void qemu_system_reset(ShutdownCause reason);
     ^
/Users/pm215/src/qemu-for-merges/ui/cocoa.m:1177:5: error: implicit
declaration of function 'qmp_system_powerdown' is invalid in C99
[-Werror,-Wimplicit-function-declaration]
    qmp_system_powerdown(NULL);
    ^
  CC      ui/vnc-jobs.o
/Users/pm215/src/qemu-for-merges/ui/cocoa.m:1194:5: error: implicit
declaration of function 'qmp_eject' is invalid in C99
[-Werror,-Wimplicit-function-declaration]
    qmp_eject(true, [drive cStringUsingEncoding: NSASCIIStringEncoding],
    ^
  CC      chardev/char.o
/Users/pm215/src/qemu-for-merges/ui/cocoa.m:1228:9: error: implicit
declaration of function 'qmp_blockdev_change_medium' is invalid in C99
[-Werror,-Wimplicit-function-declaration]
        qmp_blockdev_change_medium(true,
        ^
/Users/pm215/src/qemu-for-merges/ui/cocoa.m:1628:21: error: implicit
declaration of function 'qmp_query_block' is invalid in C99
[-Werror,-Wimplicit-function-declaration]
    currentDevice =3D qmp_query_block(NULL);
                    ^
/Users/pm215/src/qemu-for-merges/ui/cocoa.m:1628:19: error:
incompatible integer to pointer conversion assigning to 'BlockInfoList
*' (aka 'struct BlockInfoList *') from 'int'
[-Werror,-Wint-conversion]
    currentDevice =3D qmp_query_block(NULL);


thanks
-- PMM
