Received: from eggs.gnu.org ([2001:4830:134:3::10]:47715)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1edRZb-0002mA-Aj
	for qemu-devel@nongnu.org; Sun, 21 Jan 2018 21:11:00 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1edRZW-0003PM-CD
	for qemu-devel@nongnu.org; Sun, 21 Jan 2018 21:10:59 -0500
Received: from mail-qt0-x22c.google.com ([2607:f8b0:400d:c0d::22c]:34557)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1edRZW-0003P8-7E
	for qemu-devel@nongnu.org; Sun, 21 Jan 2018 21:10:54 -0500
Received: by mail-qt0-x22c.google.com with SMTP id a27so4114985qtd.1
	for <qemu-devel@nongnu.org>; Sun, 21 Jan 2018 18:10:54 -0800 (PST)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <20171108022828.7242-1-f4bug@amsat.org>
	<20171108022828.7242-2-f4bug@amsat.org>
	<20171108202924.GV3111@localhost.localdomain>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <915da050-14bd-50ad-9a0d-5ad81fd34073@amsat.org>
Date: Sun, 21 Jan 2018 23:10:48 -0300
MIME-Version: 1.0
In-Reply-To: <20171108202924.GV3111@localhost.localdomain>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [RFC PATCH 1/6] machine: add a deprecated_reason
 property
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: Eduardo Habkost <ehabkost@redhat.com>, Peter Maydell <peter.maydell@linaro.org>, Alistair Francis <alistair.francis@xilinx.com>, Paolo Bonzini <pbonzini@redhat.com>, Thomas Huth <thuth@redhat.com>, Marcel Apfelbaum <marcel@redhat.com>, Michael Roth <mdroth@linux.vnet.ibm.com>, qemu-devel@nongnu.org

Hi Thomas,

> This series introduces 5 different flavors of deprecation
> messages:
> 
> * "Too old"
> * "Unmaintained"
> * "The ZCU102 machine has the same features supported"
> * "Use the \"pc\" machine instead"
> * "Obsoleted by the \"40p\" machine"
> 
> Can we clearly document guidelines and examples for values of
> this field, to help ensure consistency?
> 
> Examples of questions that could be answered in the field
> documentation:
> 
> * Should the message start with an uppercase letter?
> * Should it really explain _why_ it was deprecated, or is a
>   simple "please use xlnx-zcu102 instead" good enough?
> * Which of the following is preferred:
>   * "obsoleted by the \"pc\" machine"
>   * "obsoleted by \"pc\""
>   * "use \"pc\" instead"
>   * "too old, use \"pc\" instead"
>   * "too old; use \"pc\" instead"
>   * <something else?>

Do you have any preference regarding Eduardo's suggestions?

I see this pattern:

- obsoleted by newer
  -> hint about replacement
- too old, unmaintained (maybe suggest use an older version?)
  -> hint when removal is scheduled

These are also valid for Devices.

Now if we want a consistent guideline, I suggest we clearly document the
deprecated machines/devices in qemu-doc.texi and extract this
information at build time, like trace.h.
At least this will force developers to document their deprecations.
