Received: from eggs.gnu.org ([2001:4830:134:3::10]:39147)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fB825-0001Q0-GN
	for qemu-devel@nongnu.org; Tue, 24 Apr 2018 20:11:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fB822-0005DR-QN
	for qemu-devel@nongnu.org; Tue, 24 Apr 2018 20:11:37 -0400
Received: from mail-pg0-x233.google.com ([2607:f8b0:400e:c05::233]:35774)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1fB822-0005D6-KY
	for qemu-devel@nongnu.org; Tue, 24 Apr 2018 20:11:34 -0400
Received: by mail-pg0-x233.google.com with SMTP id j11so12022186pgf.2
	for <qemu-devel@nongnu.org>; Tue, 24 Apr 2018 17:11:34 -0700 (PDT)
References: <20180424152405.10304-1-alex.bennee@linaro.org>
	<20180424152405.10304-5-alex.bennee@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <016e4b13-172d-63ad-53d6-55ac93ad853f@linaro.org>
Date: Tue, 24 Apr 2018 14:11:29 -1000
MIME-Version: 1.0
In-Reply-To: <20180424152405.10304-5-alex.bennee@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v3 04/46] configure: move i386_cc to
 cross_cc_i386
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
> Also dont assume x86_64 compiler can build i386 binaries.
> 
> Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
> Tested-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
> 
> ---
> v2
>   - drop using system x86_64 compiler for i386 compiles
> v3
>   - fix cross_cc_i386 when on i386
> ---
>  configure | 24 ++++++++++++++++--------
>  1 file changed, 16 insertions(+), 8 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~
