Received: from eggs.gnu.org ([2001:4830:134:3::10]:44359)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1gSJDK-0006lK-55
	for qemu-devel@nongnu.org; Thu, 29 Nov 2018 05:06:30 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1gSJDF-0005nt-87
	for qemu-devel@nongnu.org; Thu, 29 Nov 2018 05:06:30 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:51881)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1gSJDE-0005nH-Vc
	for qemu-devel@nongnu.org; Thu, 29 Nov 2018 05:06:25 -0500
Received: by mail-wm1-f68.google.com with SMTP id s14so1604410wmh.1
	for <qemu-devel@nongnu.org>; Thu, 29 Nov 2018 02:06:24 -0800 (PST)
Received: from ?IPv6:2001:b07:6468:f312:70a0:7021:f11e:d31d?
	([2001:b07:6468:f312:70a0:7021:f11e:d31d])
	by smtp.gmail.com with ESMTPSA id
	k73sm1353993wmd.36.2018.11.29.02.06.22 for <qemu-devel@nongnu.org>
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Thu, 29 Nov 2018 02:06:22 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
References: <20181129090120.28828-1-pbonzini@redhat.com>
	<20181129090120.28828-5-pbonzini@redhat.com>
Message-ID: <4624efad-cb87-462e-304e-0fcfd4440431@redhat.com>
Date: Thu, 29 Nov 2018 11:06:21 +0100
MIME-Version: 1.0
In-Reply-To: <20181129090120.28828-5-pbonzini@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH for-4.0 4/4] checkpatch: colorize output to
 terminal
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

On 29/11/18 10:01, Paolo Bonzini wrote:
>  
> +if ($color =~ /^[01]$/) {
> +	$color = !$color;
> +} elsif ($color =~ /^always$/i) {

This first "if" is unnecessary, not sure why Linux has it (probably
because it implements --nocolor differently).

Paolo
