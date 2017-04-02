Received: from eggs.gnu.org ([2001:4830:134:3::10]:49635)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <sameeh@daynix.com>) id 1cua0a-0004dK-V9
	for qemu-devel@nongnu.org; Sun, 02 Apr 2017 03:33:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <sameeh@daynix.com>) id 1cua0X-00014E-Pd
	for qemu-devel@nongnu.org; Sun, 02 Apr 2017 03:33:08 -0400
Received: from mail-ua0-x242.google.com ([2607:f8b0:400c:c08::242]:33558)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <sameeh@daynix.com>) id 1cua0X-00013q-JN
	for qemu-devel@nongnu.org; Sun, 02 Apr 2017 03:33:05 -0400
Received: by mail-ua0-x242.google.com with SMTP id 9so2180667uau.0
	for <qemu-devel@nongnu.org>; Sun, 02 Apr 2017 00:33:05 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20170321141435.23701-1-sameeh@daynix.com>
References: <20170321141435.23701-1-sameeh@daynix.com>
From: Sameeh Jubran <sameeh@daynix.com>
Date: Sun, 2 Apr 2017 10:33:04 +0300
Message-ID: <CAKPgXcFGZKw+FifF0aPS9h=MdtR26=b7D9CHKgyPnD-_p7TNGw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: Re: [Qemu-devel] [PATCH qemu-ga] qemu-ga: Don't display errors to
 the user on thaw command
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: QEMU Developers <qemu-devel@nongnu.org>, Michael Roth <mdroth@linux.vnet.ibm.com>
Cc: Yan Vugenfirer <yan@daynix.com>

Ping.

On Tue, Mar 21, 2017 at 5:14 PM, Sameeh Jubran <sameeh@daynix.com> wrote:

> Errors that are related to ur inner implementation for the thaw command
> shouldn't be displayed to the user.
>
> Signed-off-by: Sameeh Jubran <sameeh@daynix.com>
> ---
>  qga/vss-win32/requester.cpp | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
>
> diff --git a/qga/vss-win32/requester.cpp b/qga/vss-win32/requester.cpp
> index 0cd2f0e..272e71b 100644
> --- a/qga/vss-win32/requester.cpp
> +++ b/qga/vss-win32/requester.cpp
> @@ -463,7 +463,7 @@ void requester_thaw(int *num_vols, ErrorSet *errset)
>              hr = WaitForAsync(pAsync);
>          }
>          if (FAILED(hr)) {
> -            err_set(errset, hr, "failed to complete backup");
> +            fprintf(stderr, "failed to complete backup");
>          }
>          break;
>
> @@ -480,18 +480,18 @@ void requester_thaw(int *num_vols, ErrorSet *errset)
>
>      case VSS_E_UNEXPECTED_PROVIDER_ERROR:
>          if (WaitForSingleObject(vss_ctx.hEventTimeout, 0) !=
> WAIT_OBJECT_0) {
> -            err_set(errset, hr, "unexpected error in VSS provider");
> +            fprintf(stderr, "unexpected error in VSS provider");
>              break;
>          }
>          /* fall through if hEventTimeout is signaled */
>
>      case (HRESULT)VSS_E_HOLD_WRITES_TIMEOUT:
> -        err_set(errset, hr, "couldn't hold writes: "
> +        fprintf(stderr, "couldn't hold writes: "
>                  "fsfreeze is limited up to 10 seconds");
>          break;
>
>      default:
> -        err_set(errset, hr, "failed to do snapshot set");
> +        fprintf(stderr, "failed to do snapshot set");
>      }
>
>      if (err_is_set(errset)) {
> --
> 2.9.3
>
>


-- 
Respectfully,
*Sameeh Jubran*
*Linkedin <https://il.linkedin.com/pub/sameeh-jubran/87/747/a8a>*
*Software Engineer @ Daynix <http://www.daynix.com>.*
