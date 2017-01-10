Received: from eggs.gnu.org ([2001:4830:134:3::10]:52360)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1cR2in-0007OY-Hp
	for qemu-devel@nongnu.org; Tue, 10 Jan 2017 15:08:42 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1cR2ik-0003gy-To
	for qemu-devel@nongnu.org; Tue, 10 Jan 2017 15:08:41 -0500
Received: from mail-pf0-x242.google.com ([2607:f8b0:400e:c00::242]:33897)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <rth7680@gmail.com>) id 1cR2ik-0003gb-Nu
	for qemu-devel@nongnu.org; Tue, 10 Jan 2017 15:08:38 -0500
Received: by mail-pf0-x242.google.com with SMTP id y143so9220918pfb.1
	for <qemu-devel@nongnu.org>; Tue, 10 Jan 2017 12:08:38 -0800 (PST)
Sender: Richard Henderson <rth7680@gmail.com>
References: <148295045448.19871.9819696634619157347.stgit@fimbulvetr.bsc.es>
	<148295046527.19871.6610919709371885230.stgit@fimbulvetr.bsc.es>
From: Richard Henderson <rth@twiddle.net>
Message-ID: <6c1d8806-bb65-8be6-fb95-faf2f0633e21@twiddle.net>
Date: Tue, 10 Jan 2017 12:08:33 -0800
MIME-Version: 1.0
In-Reply-To: <148295046527.19871.6610919709371885230.stgit@fimbulvetr.bsc.es>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v6 2/7] trace: Make
 trace_get_vcpu_event_count() inlinable
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Llu=c3=ads_Vilanova?= <vilanova@ac.upc.edu>, qemu-devel@nongnu.org
Cc: Eduardo Habkost <ehabkost@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>

On 12/28/2016 10:41 AM, Lluís Vilanova wrote:
> @@ -82,6 +83,10 @@ static inline bool trace_event_get_vcpu_state_dynamic(CPUState *vcpu,
>      return trace_event_get_vcpu_state_dynamic_by_vcpu_id(vcpu, vcpu_id);
>  }
>
> +static inline uint32_t trace_get_vcpu_event_count(void)
> +{
> +    return trace_next_vcpu_id;
> +}
...
> @@ -237,7 +237,7 @@ char *trace_opt_parse(const char *optarg);
>   *
>   * Return the number of known vcpu-specific events
>   */
> -uint32_t trace_get_vcpu_event_count(void);
> +static uint32_t trace_get_vcpu_event_count(void);

This second declaration should be removed.



r~
