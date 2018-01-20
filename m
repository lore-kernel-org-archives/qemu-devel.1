Received: from eggs.gnu.org ([208.118.235.92]:44194)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1echJP-0000CR-22
	for qemu-devel@nongnu.org; Fri, 19 Jan 2018 19:47:38 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1echIx-000485-RZ
	for qemu-devel@nongnu.org; Fri, 19 Jan 2018 19:47:11 -0500
Received: from mail-pf0-x22a.google.com ([2607:f8b0:400e:c00::22a]:34913)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1echIx-00045v-Ip
	for qemu-devel@nongnu.org; Fri, 19 Jan 2018 19:46:43 -0500
Received: by mail-pf0-x22a.google.com with SMTP id t12so2603364pfg.2
	for <qemu-devel@nongnu.org>; Fri, 19 Jan 2018 16:46:43 -0800 (PST)
References: <20180119143951.5810-1-f4bug@amsat.org>
	<20180119180133.GG2430@work-vm>
	<39b15cc5-f797-8902-4b42-bf25845e7e74@amsat.org>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <3fcd8dff-eb50-4a43-e3fc-101c17ecb849@linaro.org>
Date: Fri, 19 Jan 2018 16:46:38 -0800
MIME-Version: 1.0
In-Reply-To: <39b15cc5-f797-8902-4b42-bf25845e7e74@amsat.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [RFC PATCH] migration: do not use
 atomic__nocheck() functions directly
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Cc: Juan Quintela <quintela@redhat.com>, Alexey Perevalov <a.perevalov@samsung.com>, qemu-devel@nongnu.org

On 01/19/2018 10:20 AM, Philippe Mathieu-Daudé wrote:
> Maybe we should remove the __nocheck() functions and inline them in the
> 'checked' functions?

No, I use them in TCG, properly protected with CONFIG_ATOMIC*.


r~
