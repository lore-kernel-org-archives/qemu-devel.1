Received: from eggs.gnu.org ([2001:4830:134:3::10]:43737)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1d1bqA-0002OP-Dr
	for qemu-devel@nongnu.org; Fri, 21 Apr 2017 12:55:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1d1bq9-0001WI-Eg
	for qemu-devel@nongnu.org; Fri, 21 Apr 2017 12:55:26 -0400
Received: from mail-wr0-x234.google.com ([2a00:1450:400c:c0c::234]:33002)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1d1bq9-0001Vx-6d
	for qemu-devel@nongnu.org; Fri, 21 Apr 2017 12:55:25 -0400
Received: by mail-wr0-x234.google.com with SMTP id w50so34965681wrc.0
	for <qemu-devel@nongnu.org>; Fri, 21 Apr 2017 09:55:24 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20170421134644.10239-1-jcody@redhat.com>
References: <20170421134644.10239-1-jcody@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 21 Apr 2017 17:55:02 +0100
Message-ID: <CAFEAcA95ex0YG4tD-qdSQrfEiL-RFWumq-qGS3Ej=o6MUmA7Jw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: Re: [Qemu-devel] [PULL 00/12] Block patches
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Jeff Cody <jcody@redhat.com>
Cc: Qemu-block <qemu-block@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>

On 21 April 2017 at 14:46, Jeff Cody <jcody@redhat.com> wrote:
> The following changes since commit bfec359afba088aaacc7d316f43302f28c6e642a:
>
>   Merge remote-tracking branch 'remotes/armbru/tags/pull-qdev-2017-04-21' into staging (2017-04-21 11:42:03 +0100)
>
> are available in the git repository at:
>
>   git://github.com/codyprime/qemu-kvm-jtc.git tags/block-pull-request
>
> for you to fetch changes up to 1507631e438930bc07f776f303af127a9cdb4d41:
>
>   qemu-iotests: _cleanup_qemu must be called on exit (2017-04-21 08:32:44 -0400)
>
> ----------------------------------------------------------------
>
> Block patches for 2.10
>

Hi, I'm afraid this runs into format string compile issues:

In file included from block/trace.c:4:
/Users/pm215/src/qemu-for-merges/build/all/block/trace.h:1465:42:
error: format specifies type 'unsigned long' but the argument has type
'uint64_t' (aka 'unsigned long long') [-Werror,-Wformat]
                          , guid, iodir, size, off, acb, ret, err);
                                         ^~~~
/Users/pm215/src/qemu-for-merges/include/qemu/log.h:94:30: note:
expanded from macro 'qemu_log_mask'
            qemu_log(FMT, ## __VA_ARGS__);              \
                             ^
In file included from block/trace.c:4:
/Users/pm215/src/qemu-for-merges/build/all/block/trace.h:1465:48:
error: format specifies type 'unsigned long' but the argument has type
'uint64_t' (aka 'unsigned long long') [-Werror,-Wformat]
                          , guid, iodir, size, off, acb, ret, err);
                                               ^~~
/Users/pm215/src/qemu-for-merges/include/qemu/log.h:94:30: note:
expanded from macro 'qemu_log_mask'
            qemu_log(FMT, ## __VA_ARGS__);              \
                             ^
In file included from block/trace.c:4:
/Users/pm215/src/qemu-for-merges/build/all/block/trace.h:1493:41:
error: format specifies type 'unsigned long' but the argument has type
'uint64_t' (aka 'unsigned long long') [-Werror,-Wformat]
                          , vdisk_guid, vdisk_size);
                                        ^~~~~~~~~~
/Users/pm215/src/qemu-for-merges/include/qemu/log.h:94:30: note:
expanded from macro 'qemu_log_mask'
            qemu_log(FMT, ## __VA_ARGS__);              \
                             ^
In file included from block/trace.c:4:
/Users/pm215/src/qemu-for-merges/build/all/block/trace.h:1507:34:
error: format specifies type 'long' but the argument has type
'uint64_t' (aka 'unsigned long long') [-Werror,-Wformat]
                          , acb, ret);
                                 ^~~
/Users/pm215/src/qemu-for-merges/include/qemu/log.h:94:30: note:
expanded from macro 'qemu_log_mask'
            qemu_log(FMT, ## __VA_ARGS__);              \
                             ^
4 errors generated.


Those are the OSX errors, but the compile also fails for 32-bit
hosts (including w32).

thanks
-- PMM
