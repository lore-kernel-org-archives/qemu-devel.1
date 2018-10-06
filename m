Received: from eggs.gnu.org ([2001:4830:134:3::10]:58000)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1g8rHh-00066x-Le
	for qemu-devel@nongnu.org; Sat, 06 Oct 2018 14:26:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1g8rHd-0007aE-L0
	for qemu-devel@nongnu.org; Sat, 06 Oct 2018 14:26:37 -0400
Received: from mail-pf1-x42b.google.com ([2607:f8b0:4864:20::42b]:37056)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1g8rHd-0007Wv-8l
	for qemu-devel@nongnu.org; Sat, 06 Oct 2018 14:26:33 -0400
Received: by mail-pf1-x42b.google.com with SMTP id j23-v6so6546703pfi.4
	for <qemu-devel@nongnu.org>; Sat, 06 Oct 2018 11:26:32 -0700 (PDT)
References: <20181005154910.3099-1-alex.bennee@linaro.org>
	<20181005154910.3099-6-alex.bennee@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <1a26b698-56d2-0137-d395-38f575d22ba3@linaro.org>
Date: Sat, 6 Oct 2018 11:26:28 -0700
MIME-Version: 1.0
In-Reply-To: <20181005154910.3099-6-alex.bennee@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [RFC PATCH 05/21] trace: keep a count of
 trace-point hits
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>, qemu-devel@nongnu.org
Cc: Stefan Hajnoczi <stefanha@redhat.com>, cota@braap.org, vilanova@ac.upc.edu, Pavel.Dovgaluk@ispras.ru

On 10/5/18 8:48 AM, Alex Bennée wrote:
> @@ -81,6 +81,8 @@ def generate_c(event, group):
>          cond = "trace_event_get_state(%s)" % event_id
>  
>      out('',
> +        '    %(event_obj)s.count++;',
> +        '',
>          '    if (!%(cond)s) {',
>          '        return;',
>          '    }',

Is it really "hit" if the condition isn't true?  And you'd want to document the
non-atomicity in a comment, lest it be "fixed" later.


r~
