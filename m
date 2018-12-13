Received: from eggs.gnu.org ([2001:4830:134:3::10]:59463)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gXahq-00058o-Jq
	for qemu-devel@nongnu.org; Thu, 13 Dec 2018 18:47:51 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gXahk-0003Su-Gx
	for qemu-devel@nongnu.org; Thu, 13 Dec 2018 18:47:50 -0500
Received: from mail-oi1-x241.google.com ([2607:f8b0:4864:20::241]:44007)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1gXahe-0002yF-AG
	for qemu-devel@nongnu.org; Thu, 13 Dec 2018 18:47:39 -0500
Received: by mail-oi1-x241.google.com with SMTP id u18so3122890oie.10
	for <qemu-devel@nongnu.org>; Thu, 13 Dec 2018 15:47:31 -0800 (PST)
References: <f4349b9ee95cbd9d5b16e9033fdf0d7c9e99aebf.camel@kernel.crashing.org>
	<a9dd602b-9eb1-f57a-ef21-31f08fc18729@linaro.org>
	<62acd980b74d7c6fd325e19890e4f9f25a74bf5d.camel@kernel.crashing.org>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <4e581919-0e2b-d155-69ee-a4427438792f@linaro.org>
Date: Thu, 13 Dec 2018 17:47:27 -0600
MIME-Version: 1.0
In-Reply-To: <62acd980b74d7c6fd325e19890e4f9f25a74bf5d.camel@kernel.crashing.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [RFC/PATCH] i386: Atomically update PTEs with mttcg
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>, qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>

On 12/13/18 5:39 PM, Benjamin Herrenschmidt wrote:
> At this point I'd rather not take chances and introduce more bugs, so
> I'll post an updated variant with a few fixes but will postpone more
> refactoring unless you really really want them now :)

No, that's quite all right.  Thanks for the investigation.

r~
