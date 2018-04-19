Received: from eggs.gnu.org ([2001:4830:134:3::10]:45590)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1f9G30-0003Vv-Bx
	for qemu-devel@nongnu.org; Thu, 19 Apr 2018 16:20:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1f9G2x-0001Ia-0l
	for qemu-devel@nongnu.org; Thu, 19 Apr 2018 16:20:50 -0400
Received: from mail-pg0-x235.google.com ([2607:f8b0:400e:c05::235]:39277)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1f9G2w-0001He-Rm
	for qemu-devel@nongnu.org; Thu, 19 Apr 2018 16:20:46 -0400
Received: by mail-pg0-x235.google.com with SMTP id b9so3018418pgf.6
	for <qemu-devel@nongnu.org>; Thu, 19 Apr 2018 13:20:46 -0700 (PDT)
References: <20180419135901.30035-1-alex.bennee@linaro.org>
	<20180419135901.30035-4-alex.bennee@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <3dd9c647-210c-981b-9876-ecd53ad058fd@linaro.org>
Date: Thu, 19 Apr 2018 10:20:39 -1000
MIME-Version: 1.0
In-Reply-To: <20180419135901.30035-4-alex.bennee@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v2 03/43] configure: add support for
 --cross-cc-FOO
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

On 04/19/2018 03:58 AM, Alex Bennée wrote:
> @@ -6805,6 +6823,7 @@ case "$target_name" in
>      bflt="yes"
>      mttcg="yes"
>      gdb_xml_files="arm-core.xml arm-vfp.xml arm-vfp3.xml arm-neon.xml"
> +    target_compiler=$cross_cc_arm
>    ;;
>    aarch64|aarch64_be)
>      TARGET_ARCH=aarch64
> @@ -6812,6 +6831,7 @@ case "$target_name" in
>      bflt="yes"
>      mttcg="yes"
>      gdb_xml_files="aarch64-core.xml aarch64-fpu.xml arm-core.xml arm-vfp.xml arm-vfp3.xml arm-neon.xml"
> +    target_compiler=$cross_cc_aarch64
>    ;;
>    cris)
>    ;;

Is there any reason not to fill in the reset of the cases within the switch at
the same time?


r~
