Received: from eggs.gnu.org ([2001:4830:134:3::10]:39233)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fB82j-0001mD-E9
	for qemu-devel@nongnu.org; Tue, 24 Apr 2018 20:12:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fB82g-0005ZP-PO
	for qemu-devel@nongnu.org; Tue, 24 Apr 2018 20:12:17 -0400
Received: from mail-pf0-x244.google.com ([2607:f8b0:400e:c00::244]:45879)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1fB82g-0005ZC-Jc
	for qemu-devel@nongnu.org; Tue, 24 Apr 2018 20:12:14 -0400
Received: by mail-pf0-x244.google.com with SMTP id l27so13608147pfk.12
	for <qemu-devel@nongnu.org>; Tue, 24 Apr 2018 17:12:14 -0700 (PDT)
References: <20180424152405.10304-1-alex.bennee@linaro.org>
	<20180424152405.10304-6-alex.bennee@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <8a388a86-a498-d964-0a6a-a3f6d93963ab@linaro.org>
Date: Tue, 24 Apr 2018 14:12:09 -1000
MIME-Version: 1.0
In-Reply-To: <20180424152405.10304-6-alex.bennee@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v3 05/46] configure: allow user to specify
 --cross-cc-cflags-foo=
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>, peter.maydell@linaro.org, cota@braap.org, famz@redhat.com, berrange@redhat.com, f4bug@amsat.org, balrogg@gmail.com, aurelien@aurel32.net, agraf@suse.de
Cc: qemu-devel@nongnu.org

On 04/24/2018 05:23 AM, Alex Bennée wrote:
> As an individual compiler may be able to support several targets with
> the appropriate flags we need to expose this to the user as well.
> 
> Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
> 
> ---
> v3
>   - fix up the cross-cc
> ---
>  configure | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 
> diff --git a/configure b/configure
> index ffd96d930f..282e1f1e2b 100755
> --- a/configure
> +++ b/configure
> @@ -454,7 +454,10 @@ docker="no"
>  

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~
