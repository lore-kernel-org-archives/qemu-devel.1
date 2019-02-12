Received: from eggs.gnu.org ([209.51.188.92]:51747)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1gtVns-0004fK-Gt
	for qemu-devel@nongnu.org; Tue, 12 Feb 2019 06:00:41 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1gtVnf-00055Z-2Y
	for qemu-devel@nongnu.org; Tue, 12 Feb 2019 06:00:35 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:40948)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1gtVnX-0004qF-IJ
	for qemu-devel@nongnu.org; Tue, 12 Feb 2019 06:00:21 -0500
Received: by mail-wr1-f67.google.com with SMTP id q1so2153636wrp.7
	for <qemu-devel@nongnu.org>; Tue, 12 Feb 2019 03:00:19 -0800 (PST)
References: <20190211163829.10297-1-pbonzini@redhat.com>
	<002847d1-732d-b777-394c-a784fd359130@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <d04e8fd5-0db7-b3af-6c14-3fa59827292b@redhat.com>
Date: Tue, 12 Feb 2019 12:00:17 +0100
MIME-Version: 1.0
In-Reply-To: <002847d1-732d-b777-394c-a784fd359130@redhat.com>
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
To: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, armbru@redhat.com

On 12/02/19 10:13, Thomas Huth wrote:
>> +Unlike Linux, there is no user interface to edit the configuration, which is instead
>> +specified in per-target files under the ``default-configs/`` directory of the
>> +QEMU source tree.  This is because, unlike Linux, configuration and dependencies can be
>> +treated as a black box when building QEMU; the default configuration that QEMU
>> +ships with should be okay in almost all cases.
> I'd like to suggest to replace "Linux" with "Linux-Kconfig".

Here I think it's really Linux vs. QEMU, not Linux-Kconfig versus
minikconf.  However...

> [...]
>> +**reverse dependencies**: ``select <symbol> [if <expr>]``
>> +
>> +  While ``depends on`` forces a symbol to false, reverse dependencies can be
>> +  used to force another symbol to true.  In the following example,
>> +  ``CONFIG_BAZ`` will be true whenever ``CONFIG_FOO`` is true::
>> +
>> +    config FOO
>> +      select BAZ
>> +
>> +  The optional expression will prevent ``select`` from having any effect
>> +  unless it is true.
>> +
>> +  Note that unlike Linux, QEMU will detect contradictions between ``depends on`` and
> dito

...  I'll do the replacement you suggest here.

Paolo
