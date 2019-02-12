Received: from eggs.gnu.org ([209.51.188.92]:39599)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1gtWEI-0007tp-Gf
	for qemu-devel@nongnu.org; Tue, 12 Feb 2019 06:27:59 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1gtWEH-0001I7-J3
	for qemu-devel@nongnu.org; Tue, 12 Feb 2019 06:27:58 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:33651)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1gtWEF-00018F-6r
	for qemu-devel@nongnu.org; Tue, 12 Feb 2019 06:27:57 -0500
Received: by mail-wm1-f66.google.com with SMTP id h22so1123649wmb.0
	for <qemu-devel@nongnu.org>; Tue, 12 Feb 2019 03:27:48 -0800 (PST)
References: <20190211163829.10297-1-pbonzini@redhat.com>
	<20190211181707.05e8596a.cohuck@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <36b82cce-a2e3-1c33-d8dd-c427274c8881@redhat.com>
Date: Tue, 12 Feb 2019 12:27:46 +0100
MIME-Version: 1.0
In-Reply-To: <20190211181707.05e8596a.cohuck@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] Kconfig: add documentation
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Cornelia Huck <cohuck@redhat.com>
Cc: peter.maydell@linaro.org, thuth@redhat.com, Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, qemu-devel@nongnu.org, armbru@redhat.com

On 11/02/19 18:17, Cornelia Huck wrote:
>> +
>> +This domain-specific language is based on the Kconfig language that originated in the
>> +Linux kernel, though it was heavily simplified and the handling of dependencies is
>> +stricter in QEMU.
>> +
>> +Unlike Linux, there is no user interface to edit the configuration, which is instead
>> +specified in per-target files under the ``default-configs/`` directory of the
>> +QEMU source tree.  This is because, unlike Linux, configuration and dependencies can be
>> +treated as a black box when building QEMU; the default configuration that QEMU
>> +ships with should be okay in almost all cases.
> So this is only about devices and friends, and not about cpu features
> etc.?
> 

For now it is...  Ideas are welcome on extensions to the mechanism; for
now it is only about what default-configs/ has always covered, just
better. :)

Paolo
