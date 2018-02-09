Received: from eggs.gnu.org ([2001:4830:134:3::10]:49063)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1ek78P-00037E-Me
	for qemu-devel@nongnu.org; Fri, 09 Feb 2018 06:46:35 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1ek78O-0002MM-La
	for qemu-devel@nongnu.org; Fri, 09 Feb 2018 06:46:29 -0500
Received: from mail-oi0-x231.google.com ([2607:f8b0:4003:c06::231]:32868)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1ek78O-0002M0-GQ
	for qemu-devel@nongnu.org; Fri, 09 Feb 2018 06:46:28 -0500
Received: by mail-oi0-x231.google.com with SMTP id l8so5928027oig.0
	for <qemu-devel@nongnu.org>; Fri, 09 Feb 2018 03:46:28 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20180209050329.15094-1-armbru@redhat.com>
References: <20180209050329.15094-1-armbru@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 9 Feb 2018 11:46:07 +0000
Message-ID: <CAFEAcA84hpU_Abf_8dOGFTxD1iRzey2+b1HL7RZTf=LFiEcyhQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PULL v3 00/20] Miscellaneous patches for
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

On 9 February 2018 at 05:03, Markus Armbruster <armbru@redhat.com> wrote:
> The following changes since commit 008a51bbb343972dd8cf09126da8c3b87f4e1c96:
>
>   Merge remote-tracking branch 'remotes/famz/tags/staging-pull-request' into staging (2018-02-08 14:31:51 +0000)
>
> are available in the git repository at:
>
>   git://repo.or.cz/qemu/armbru.git tags/pull-misc-2018-02-07-v3
>
> for you to fetch changes up to 59a92828ad355a0194248cab9ce98dddced04363:
>
>   Move include qemu/option.h from qemu-common.h to actual users (2018-02-09 05:07:33 +0100)
>
> ----------------------------------------------------------------
> Miscellaneous patches for 2018-02-07
>

Hi. This seems to have the same OSX build errors as v1:

/Users/pm215/src/qemu-for-merges/ui/cocoa.m:256:49: error: implicit
declaration of function 'error_get_pretty' is invalid in C99
[-Werror,-Wimplicit-function-declaration]
        QEMU_Alert([NSString stringWithCString: error_get_pretty(err)
                                                ^
  CC      chardev/char.o
/Users/pm215/src/qemu-for-merges/ui/cocoa.m:256:49: error:
incompatible integer to pointer conversion sending 'int' to parameter
of type 'const char * _Nonnull' [-Werror,-Wint-conversion]
        QEMU_Alert([NSString stringWithCString: error_get_pretty(err)
                                                ^~~~~~~~~~~~~~~~~~~~~
/Applications/Xcode.app/Contents/Developer/Platforms/MacOSX.platform/Developer/SDKs/MacOSX10.11.sdk/System/Library/Frameworks/Foundation.framework/Headers/NSString.h:350:58:
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
/sw/include/glib-2.0/glib/gerror.h:56:10: note: 'g_error_free' declared here
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
/Users/pm215/src/qemu-for-merges/ui/cocoa.m:1194:5: error: implicit
declaration of function 'qmp_eject' is invalid in C99
[-Werror,-Wimplicit-function-declaration]
    qmp_eject(true, [drive cStringUsingEncoding: NSASCIIStringEncoding],
    ^
/Users/pm215/src/qemu-for-merges/ui/cocoa.m:1228:9: error: implicit
declaration of function 'qmp_blockdev_change_medium' is invalid in C99
[-Werror,-Wimplicit-function-declaration]
        qmp_blockdev_change_medium(true,
        ^
  CC      chardev/char-fd.o
/Users/pm215/src/qemu-for-merges/ui/cocoa.m:1628:21: error: implicit
declaration of function 'qmp_query_block' is invalid in C99
[-Werror,-Wimplicit-function-declaration]
    currentDevice = qmp_query_block(NULL);
                    ^
/Users/pm215/src/qemu-for-merges/ui/cocoa.m:1628:19: error:
incompatible integer to pointer conversion assigning to 'BlockInfoList
*' (aka 'struct BlockInfoList *') from 'int'
[-Werror,-Wint-conversion]
    currentDevice = qmp_query_block(NULL);
                  ^ ~~~~~~~~~~~~~~~~~~~~~
11 errors generated.


thanks
-- PMM
