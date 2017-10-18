Received: from eggs.gnu.org ([2001:4830:134:3::10]:46938)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1e4oNG-0000z8-Ja
	for qemu-devel@nongnu.org; Wed, 18 Oct 2017 09:27:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1e4oNB-0003KO-8P
	for qemu-devel@nongnu.org; Wed, 18 Oct 2017 09:27:06 -0400
Received: from mail-pg0-x233.google.com ([2607:f8b0:400e:c05::233]:48395)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1e4oNB-0003K5-0m
	for qemu-devel@nongnu.org; Wed, 18 Oct 2017 09:27:01 -0400
Received: by mail-pg0-x233.google.com with SMTP id v78so4278423pgb.5
	for <qemu-devel@nongnu.org>; Wed, 18 Oct 2017 06:27:00 -0700 (PDT)
References: <20171017153742.10026-1-richard.henderson@linaro.org>
	<20171017153742.10026-10-richard.henderson@linaro.org>
	<1508305702.10073.2.camel@redhat.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <1df815a6-007c-849a-792d-4f177f6a463c@linaro.org>
Date: Wed, 18 Oct 2017 06:26:56 -0700
MIME-Version: 1.0
In-Reply-To: <1508305702.10073.2.camel@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v5 9/9] disas: Add capstone as submodule
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Gerd Hoffmann <kraxel@redhat.com>, qemu-devel@nongnu.org

On 10/17/2017 10:48 PM, Gerd Hoffmann wrote:
>   Hi,
> 
>> +if [ "$capstone_internal" = "yes" ]; then
>> +  echo "config-host.h: subdir-capstone" >> $config_host_mak
>> +fi
> 
> I think this isn't going to work correctly.  In case both capstone and
> dtc are used we need a single line with the dependencies, i.e.
> 
>   config-host.h: subdir-dtc subdir-capstone

Why?  Without a build rule, I thought separate dependency lines accumulated.


r~
