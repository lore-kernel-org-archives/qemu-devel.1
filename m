Received: from eggs.gnu.org ([2001:4830:134:3::10]:46186)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1cSF3B-0000TE-Ma
	for qemu-devel@nongnu.org; Fri, 13 Jan 2017 22:30:42 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1cSF3A-0005yk-PE
	for qemu-devel@nongnu.org; Fri, 13 Jan 2017 22:30:41 -0500
Received: from mail-pg0-x243.google.com ([2607:f8b0:400e:c05::243]:33991)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <rth7680@gmail.com>) id 1cSF3A-0005yB-II
	for qemu-devel@nongnu.org; Fri, 13 Jan 2017 22:30:40 -0500
Received: by mail-pg0-x243.google.com with SMTP id b1so96379pgc.1
	for <qemu-devel@nongnu.org>; Fri, 13 Jan 2017 19:30:40 -0800 (PST)
Sender: Richard Henderson <rth7680@gmail.com>
References: <148434048970.31446.17153056211582691244.stgit@frigg.lan>
	<148434050231.31446.10929552655201551997.stgit@frigg.lan>
From: Richard Henderson <rth@twiddle.net>
Message-ID: <597a44c3-2518-2d24-598c-4867f57dfa7b@twiddle.net>
Date: Fri, 13 Jan 2017 19:30:37 -0800
MIME-Version: 1.0
In-Reply-To: <148434050231.31446.10929552655201551997.stgit@frigg.lan>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v7 2/7] trace: Make
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
Cc: Eric Blake <eblake@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>

On 01/13/2017 12:48 PM, Lluís Vilanova wrote:
> uring and controlling the state of tracing events.
>   *
> - * Copyright (C) 2011-2016 Lluís Vilanova <vilanova@ac.upc.edu>
> + * Copyright (C) 2011-2017 Lluís Vilanova <vilanova@ac.upc.edu>
>   *
>   * This work is licensed under the terms of the GNU GPL, version 2 or later.
>   * See the COPYING file in the top-level directory.
> @@ -237,7 +237,7 @@ char *trace_opt_parse(const char *optarg);
>   *
>   * Return the number of known vcpu-specific events
>   */
> -uint32_t trace_get_vcpu_event_count(void);
> +static uint32_t trace_get_vcpu_event_count(void);
>

Why is this declaration still here?  It's redundant with the inline.


r~
