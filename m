Received: from eggs.gnu.org ([2001:4830:134:3::10]:51965)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1dXk55-0001gv-V0
	for qemu-devel@nongnu.org; Wed, 19 Jul 2017 04:11:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1dXk54-0003nZ-VM
	for qemu-devel@nongnu.org; Wed, 19 Jul 2017 04:11:39 -0400
Received: from mail-wm0-x233.google.com ([2a00:1450:400c:c09::233]:36217)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1dXk54-0003nB-O7
	for qemu-devel@nongnu.org; Wed, 19 Jul 2017 04:11:38 -0400
Received: by mail-wm0-x233.google.com with SMTP id t70so34081830wmt.1
	for <qemu-devel@nongnu.org>; Wed, 19 Jul 2017 01:11:38 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20170718102519.15392-1-berrange@redhat.com>
References: <20170718102519.15392-1-berrange@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Wed, 19 Jul 2017 09:11:17 +0100
Message-ID: <CAFEAcA-Nri9i6woP_C954xRRdzqjtohiCjWQWSXM59knq9d5gg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PULL v1 00/18] Merge crypto 201/07/18
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Daniel P. Berrange" <berrange@redhat.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>

On 18 July 2017 at 11:25, Daniel P. Berrange <berrange@redhat.com> wrote:
> The following changes since commit 6c6076662d98c068059983d411cb2a8987ba5670:
>
>   Merge remote-tracking branch 'remotes/bonzini/tags/for-upstream' into staging (2017-07-14 12:16:09 +0100)
>
> are available in the git repository at:
>
>   git://github.com/berrange/qemu tags/pull-qcrypto-2017-07-18-1
>
> for you to fetch changes up to 0e0fb56bcc8145d956bf527bfedc2be42bca101f:
>
>   tests: crypto: add hmac speed benchmark support (2017-07-18 11:18:30 +0100)
>
> ----------------------------------------------------------------
> Merge crypto 2017/07/18 v1
>
> ----------------------------------------------------------------

Hi; I'm afraid this failed to build on clang (x86 Linux, FreeBSD,
OSX):

  CC      crypto/cipher.o
/home/petmay01/linaro/qemu-for-merges/crypto/cipher.c:177:9: error:
variable 'drv' is used uninitialized whenever 'if' condition is false
[-Werror,-Wsometimes-uninitialized]
    if (!ctx) {
        ^~~~
/home/petmay01/linaro/qemu-for-merges/crypto/cipher.c:192:30: note:
uninitialized use occurs here
    cipher->driver = (void *)drv;
                             ^~~
/home/petmay01/linaro/qemu-for-merges/crypto/cipher.c:177:5: note:
remove the 'if' if its condition is always true
    if (!ctx) {
    ^~~~~~~~~~
/home/petmay01/linaro/qemu-for-merges/crypto/cipher.c:168:29: note:
initialize the variable 'drv' to silence this warning
    QCryptoCipherDriver *drv;
                            ^
                             = NULL
1 error generated.

and also

  CC      crypto/hmac.o
/home/petmay01/linaro/qemu-for-merges/crypto/hmac.c:103:9: error:
variable 'drv' is used uninitialized whenever 'if' condition is false
[-Werror,-Wsometimes-uninitialized]
    if (!ctx) {
        ^~~~
/home/petmay01/linaro/qemu-for-merges/crypto/hmac.c:116:28: note:
uninitialized use occurs here
    hmac->driver = (void *)drv;
                           ^~~
/home/petmay01/linaro/qemu-for-merges/crypto/hmac.c:103:5: note:
remove the 'if' if its condition is always true
    if (!ctx) {
    ^~~~~~~~~~
/home/petmay01/linaro/qemu-for-merges/crypto/hmac.c:94:27: note:
initialize the variable 'drv' to silence this warning
    QCryptoHmacDriver *drv;
                          ^
                           = NULL


Looks like a false positive, I think :-(

thanks
-- PMM
