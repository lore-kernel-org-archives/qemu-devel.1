Received: from eggs.gnu.org ([2001:4830:134:3::10]:55993)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1ejVn2-0006fi-5j
	for qemu-devel@nongnu.org; Wed, 07 Feb 2018 14:53:57 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1ejVn0-0007Sc-Ts
	for qemu-devel@nongnu.org; Wed, 07 Feb 2018 14:53:56 -0500
Received: from mail-oi0-x233.google.com ([2607:f8b0:4003:c06::233]:42676)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1ejVn0-0007Rz-La
	for qemu-devel@nongnu.org; Wed, 07 Feb 2018 14:53:54 -0500
Received: by mail-oi0-x233.google.com with SMTP id u6so1588999oiv.9
	for <qemu-devel@nongnu.org>; Wed, 07 Feb 2018 11:53:54 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20180207124009.12376-1-armbru@redhat.com>
References: <20180207124009.12376-1-armbru@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Wed, 7 Feb 2018 19:53:33 +0000
Message-ID: <CAFEAcA8anqMysjfF9cvaR77Gq6myEnu+xUUMOTwDJv0na8Ek+w@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PULL 00/20] Miscellaneous patches for 2018-02-07
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

2018-02-07 12:39 GMT+00:00 Markus Armbruster <armbru@redhat.com>:
> The following changes since commit 20e0d439a6ded635ec89f6135c08cd5541c68962:
>
>   Merge remote-tracking branch 'remotes/rth/tags/pull-hppa-20180204' into staging (2018-02-06 14:21:41 +0000)
>
> are available in the git repository at:
>
>   git://repo.or.cz/qemu/armbru.git tags/pull-misc-2018-02-07
>
> for you to fetch changes up to 35aeba9964fca0c698352eeebbc9410c3d299c77:
>
>   Move include qemu/option.h from qemu-common.h to actual users (2018-02-07 13:00:03 +0100)
>
> ----------------------------------------------------------------
> Miscellaneous patches for 2018-02-07
>

Hi. This has a compile issue on OSX:

/Users/pm215/src/qemu-for-merges/block/file-posix.c:2525:28: error:
implicit declaration of function 'qdict_get_str' is invalid in C99
[-Werror,-Wimplicit-function-declaration]
    const char *filename = qdict_get_str(options, "filename");
                           ^
  CC      block/mirror.o
/Users/pm215/src/qemu-for-merges/block/file-posix.c:2525:17: error:
incompatible integer to pointer conversion initializing 'const char *'
with an expression of type 'int' [-Werror,-Wint-conversion]
    const char *filename = qdict_get_str(options, "filename");
                ^          ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
/Users/pm215/src/qemu-for-merges/block/file-posix.c:2565:9: error:
implicit declaration of function 'qdict_put_str' is invalid in C99
[-Werror,-Wimplicit-function-declaration]
        qdict_put_str(options, "filename", bsd_path);
        ^
/Users/pm215/src/qemu-for-merges/block/file-posix.c:2565:9: note: did
you mean 'qdict_get_str'?
/Users/pm215/src/qemu-for-merges/block/file-posix.c:2525:28: note:
'qdict_get_str' declared here
    const char *filename = qdict_get_str(options, "filename");
                           ^
3 errors generated.

(All the other builds went OK.)

thanks
-- PMM
