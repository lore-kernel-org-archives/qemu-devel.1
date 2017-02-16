Received: from eggs.gnu.org ([2001:4830:134:3::10]:47405)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1ceMtA-00063w-J5
	for qemu-devel@nongnu.org; Thu, 16 Feb 2017 09:18:29 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1ceMt9-0000u7-Mj
	for qemu-devel@nongnu.org; Thu, 16 Feb 2017 09:18:28 -0500
Received: from mail-wm0-x232.google.com ([2a00:1450:400c:c09::232]:36031)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1ceMt9-0000tU-GN
	for qemu-devel@nongnu.org; Thu, 16 Feb 2017 09:18:27 -0500
Received: by mail-wm0-x232.google.com with SMTP id c85so67541773wmi.1
	for <qemu-devel@nongnu.org>; Thu, 16 Feb 2017 06:18:27 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <1487253461-269218-1-git-send-email-imammedo@redhat.com>
References: <1487253461-269218-1-git-send-email-imammedo@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 16 Feb 2017 14:18:05 +0000
Message-ID: <CAFEAcA_NgmdDCfbPy+DnHQBmNGmQ4tj1z4ci+OP7+x4tHLLCxg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: Re: [Qemu-devel] [PATCH] hw/arm/virt: fix cpu object reference leak
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Igor Mammedov <imammedo@redhat.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>, qemu-arm <qemu-arm@nongnu.org>, Andrew Jones <drjones@redhat.com>

On 16 February 2017 at 13:57, Igor Mammedov <imammedo@redhat.com> wrote:
> object_new(FOO) returns an object with ref_cnt == 1
> and following
>   object_property_set_bool(cpuobj, true, "realized", NULL)
> set parent of cpuobj to '/machine/unattached' which makes
> ref_cnt == 2.
>
> Since machvirt_init() doesn't take ownership of cpuobj
> returned by object_new() it should explicitly drop
> reference to cpuobj when dangling pointer is about to
> go out of scope like it's done pc_new_cpu() to avoid
> object leak.

I've always found the object reference semantics somewhat
confusing (why does realizing a device add a reference,
for instance?). Do we document them anywhere?

thanks
-- PMM
