Received: from eggs.gnu.org ([2001:4830:134:3::10]:34177)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1eCi3E-00089p-2F
	for qemu-devel@nongnu.org; Thu, 09 Nov 2017 03:19:09 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1eCi3A-0004IJ-Px
	for qemu-devel@nongnu.org; Thu, 09 Nov 2017 03:19:04 -0500
Received: from mail-wm0-x22e.google.com ([2a00:1450:400c:c09::22e]:55873)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1eCi3A-0004HI-Gp
	for qemu-devel@nongnu.org; Thu, 09 Nov 2017 03:19:00 -0500
Received: by mail-wm0-x22e.google.com with SMTP id b189so896470wmd.4
	for <qemu-devel@nongnu.org>; Thu, 09 Nov 2017 00:19:00 -0800 (PST)
References: <20171107150558.22131-1-alex.bennee@linaro.org>
	<20171107150558.22131-8-alex.bennee@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <3aa5840c-6bd6-f585-5e4f-12219e8c6047@linaro.org>
Date: Thu, 9 Nov 2017 09:18:56 +0100
MIME-Version: 1.0
In-Reply-To: <20171107150558.22131-8-alex.bennee@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [RISU PATCH 07/10] risugen: add --sve support
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>, peter.maydell@linaro.org
Cc: qemu-arm@nongnu.org, Dave.Martin@arm.com, qemu-devel@nongnu.org

On 11/07/2017 04:05 PM, Alex Bennée wrote:
> @@ -483,6 +521,10 @@ sub write_random_aarch64_regdata($)
>          write_random_aarch64_fpdata();
>      }
>  
> +    if ($sve_enabled) {
> +        write_random_aarch64_svedata();
> +    }

Should write either sve or fpdata, but not both, since the registers overlap.


r~
