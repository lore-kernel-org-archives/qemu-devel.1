Received: from eggs.gnu.org ([2001:4830:134:3::10]:58925)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fJNVD-0000H0-5s
	for qemu-devel@nongnu.org; Thu, 17 May 2018 14:19:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fJNV9-0005ZO-5Y
	for qemu-devel@nongnu.org; Thu, 17 May 2018 14:19:47 -0400
Received: from mail-pf0-x242.google.com ([2607:f8b0:400e:c00::242]:45617)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1fJNV8-0005Z9-VM
	for qemu-devel@nongnu.org; Thu, 17 May 2018 14:19:43 -0400
Received: by mail-pf0-x242.google.com with SMTP id c10-v6so2474660pfi.12
	for <qemu-devel@nongnu.org>; Thu, 17 May 2018 11:19:42 -0700 (PDT)
References: <20180517174718.10107-1-alex.bennee@linaro.org>
	<20180517174718.10107-4-alex.bennee@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <7fa1b374-61f6-0490-a8d4-0b0c42010f0d@linaro.org>
Date: Thu, 17 May 2018 11:19:38 -0700
MIME-Version: 1.0
In-Reply-To: <20180517174718.10107-4-alex.bennee@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v4 03/49] configure: add support for
 --cross-cc-FOO
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>, cota@braap.org, famz@redhat.com, berrange@redhat.com, f4bug@amsat.org, balrogg@gmail.com, aurelien@aurel32.net, agraf@suse.de
Cc: qemu-devel@nongnu.org

On 05/17/2018 10:46 AM, Alex Bennée wrote:
> +    if ! do_compiler $target_compiler -o $TMPE $TMPC -static ; then
> +        # For host systems we might get away with building without -static
> +        if ! do_compiler $target_compiler -o $TMPE $TMPC ; then
> +            target_compiler=""
> +        else
> +            enabled_cross_compilers="${enabled_cross_compilers} ${target_compiler}"
> +            target_compiler_static="n"
> +        fi
> +    else
> +        enabled_cross_compilers="${enabled_cross_compilers} ${target_compiler}"
> +        target_compiler_static="y"
> +    fi

Better to order this with positive tests?

  if do_compiler $target_compiler -o $TMPE $TMPC -static ; then
     ...
  elif do_compiler $target_compiler -o $TMPE $TMPC ; then
     ...
  else
     ...
  fi

Is there really a benefit to $target_compiler_static above adding -static to
$cross_compiler_flags_FOO?


r~
