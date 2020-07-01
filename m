Return-Path: <SRS0=qPFU=AM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF4FDC433E0
	for <qemu-devel@archiver.kernel.org>; Wed,  1 Jul 2020 15:21:38 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A0B2220760
	for <qemu-devel@archiver.kernel.org>; Wed,  1 Jul 2020 15:21:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HGwIBDVm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A0B2220760
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42894 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jqeYL-000378-Py
	for qemu-devel@archiver.kernel.org; Wed, 01 Jul 2020 11:21:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50978)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jqeKm-0007Xw-7C
 for qemu-devel@nongnu.org; Wed, 01 Jul 2020 11:07:36 -0400
Received: from mail-ej1-x644.google.com ([2a00:1450:4864:20::644]:33936)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jqeKk-0001fB-9f
 for qemu-devel@nongnu.org; Wed, 01 Jul 2020 11:07:35 -0400
Received: by mail-ej1-x644.google.com with SMTP id y10so25138381eje.1
 for <qemu-devel@nongnu.org>; Wed, 01 Jul 2020 08:07:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=J4qbmX+uAPtSc0cDMg/pYTi/lLEXOpoblmBXxcQzGEc=;
 b=HGwIBDVmxvo0+u/zOCR+uYymsbSFZPZm0SYJ8E/BGHmsI/ir1YxZfCbHS1GFllUYIg
 1lohZFdvn+HY1W7rm/Ab7MZdqbhJ1kc64AGf2HqLYsFHmM9zzcvPvOYoonmgmEM3CVGx
 ctbuGsSs4SlP5FsJpCr42Uif3xVLIXl+Lx071osQpP6oBmbAV4QH4tLXAbMwH4D2eGM+
 X0uN9fRLl/nPijsVO3GabFA/ydDqTMhOKXvMMNwcs9G8Yh2riC8qziWtwp2tu/rlUWdz
 P8kkt0kRETWOA5A7832oWJoorSYOfvg/Ad4V8J08W44+S9r3maBeneqB4yJUX4BdQySJ
 utww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=J4qbmX+uAPtSc0cDMg/pYTi/lLEXOpoblmBXxcQzGEc=;
 b=UGZ5GskD4EGveepHpfHIjyb26WjNkx4SIBthaVOkEem0eEpJrR+KxH6s31wyttmvDA
 Zr2EJ9C6UIIrbBwe2X9lC02Hp8ag7GuYcIVa6nHY1Md3SGAJtRqposGjipcBh475HRQo
 nZ6Ih5wgPM8NLdCNTblNJAjSMZzRIgkJlT6/EfKhS8bTrZvmeSqY+zyE2bI3jpOmALGF
 +j7BrKKik8b/x7mKLxQAisGgo6bKhwc2CznU7mRk85wBFCVGBUnXCZLJiipJull+eLcT
 erOwuCghrae5WKKzImei6+GGDugZIxa1opaV95MttdeyfgG+92gMS7ZNJY6CDonVnOnU
 AkFg==
X-Gm-Message-State: AOAM533NdaCFxGqONdXIiEDpff7C/BffHEosqd+ezTB1xb5Ql3QziBWE
 pr8NeMvoXes0Td4Nl8/ea+4=
X-Google-Smtp-Source: ABdhPJxDgCA08m5yP0JBtqujWmDcUQkIGh1w7CGC8fUU1OryzKsxKNtsGlIlCgse1ZdmXg7z91JlSg==
X-Received: by 2002:a17:906:7212:: with SMTP id
 m18mr23242462ejk.29.1593616052748; 
 Wed, 01 Jul 2020 08:07:32 -0700 (PDT)
Received: from [192.168.1.37] (1.red-83-51-162.dynamicip.rima-tde.net.
 [83.51.162.1])
 by smtp.gmail.com with ESMTPSA id be2sm6385945edb.92.2020.07.01.08.07.31
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 01 Jul 2020 08:07:32 -0700 (PDT)
Subject: Re: [PATCH] scripts/get_maintainer: Use .ignoredmailmap to ignore
 invalid emails
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
References: <20200629172716.20781-1-f4bug@amsat.org>
 <8616bdd8-34a9-f737-aa9d-f11d735cc0fe@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <caee1217-867e-f2b3-68c6-3b3e87e926a9@amsat.org>
Date: Wed, 1 Jul 2020 17:07:31 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <8616bdd8-34a9-f737-aa9d-f11d735cc0fe@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::644;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-ej1-x644.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: 0
X-Spam_score: 0.0
X-Spam_bar: /
X-Spam_report: (0.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=1, FREEMAIL_FROM=0.001,
 HEADER_FROM_DIFFERENT_DOMAINS=1, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=_AUTOLEARN
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.23
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 7/1/20 4:25 PM, Paolo Bonzini wrote:
> On 29/06/20 19:27, Philippe Mathieu-Daudé wrote:
>> Sometime emails get rejected and 'bounce'. It might take time
>> between we report that, a patch is posted, reviewed, merged...
>>
>> To reduce time spent looking at bouncing emails in one mailbox,
>> add the feature to simply ignore broken email addresses. The
>> format is similar to the '.mailmap' file. Add an email address
>> in your local '.ignoredmailmap. and get_maintainer.pl won't
>> list it anymore.
>>
>> This is particularly useful when git-send-email is used with
>> the --cc-cmd argument, like suggested in QEMU wiki:
>> https://wiki.qemu.org/Contribute/SubmitAPatch#CC_the_relevant_maintainer
>>
>> Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
> 
> Do you have such a list already?

$ cat .ignoredmailmap
#
# From man git-shortlog the forms are:
#
#  Proper Name <commit@email.xx>
#  <proper@email.xx>
#
Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>
Caio Carrara <ccarrara@redhat.com>
Yongbok Kim <yongbok.kim@mips.com>
James Hogan <james.hogan@mips.com>
Paul Burton <pburton@wavecomp.com>
Alexander Graf <agraf@suse.de>
Roy Franz <roy.franz@linaro.org>
Dmitry Solodkiy <d.solodkiy@samsung.com>
Evgeny Voevodin <e.voevodin@samsung.com>
Serge Hallyn <serge.hallyn@ubuntu.com>
Pavel Dovgalyuk <pavel.dovgaluk@ispras.ru>

> 
> Paolo
> 
>> ---
>>  scripts/get_maintainer.pl | 50 +++++++++++++++++++++++++++++++++++++++
>>  1 file changed, 50 insertions(+)
>>
>> diff --git a/scripts/get_maintainer.pl b/scripts/get_maintainer.pl
>> index 271f5ff42a..7f7a4ff3ef 100755
>> --- a/scripts/get_maintainer.pl
>> +++ b/scripts/get_maintainer.pl
>> @@ -38,6 +38,7 @@
>>  my $interactive = 0;
>>  my $email_remove_duplicates = 1;
>>  my $email_use_mailmap = 1;
>> +my $email_use_ignoredmailmap = 1;
>>  my $output_multiline = 1;
>>  my $output_separator = ", ";
>>  my $output_roles = 0;
>> @@ -365,6 +366,51 @@ sub read_mailmap {
>>      close($mailmap_file);
>>  }
>>  
>> +my $ignoredmailmap;
>> +
>> +read_ignoredmailmap();
>> +
>> +sub read_ignoredmailmap {
>> +    $ignoredmailmap = {
>> +	names => {},
>> +	addresses => {}
>> +    };
>> +
>> +    return if (!$email_use_ignoredmailmap || !(-f "${lk_path}.ignoredmailmap"));
>> +
>> +    open(my $ignoredmailmap_file, '<', "${lk_path}.ignoredmailmap")
>> +	or warn "$P: Can't open .ignoredmailmap: $!\n";
>> +
>> +    while (<$ignoredmailmap_file>) {
>> +	s/#.*$//; #strip comments
>> +	s/^\s+|\s+$//g; #trim
>> +
>> +	next if (/^\s*$/); #skip empty lines
>> +	#entries have one of the following formats:
>> +	# name1 <mail1>
>> +	# <mail1>
>> +
>> +	if (/^([^<]+)<([^>]+)>$/) {
>> +	    my $real_name = $1;
>> +	    my $address = $2;
>> +
>> +	    $real_name =~ s/\s+$//;
>> +	    ($real_name, $address) = parse_email("$real_name <$address>");
>> +	    $ignoredmailmap->{$address} = 1;
>> +	} elsif (/^(.+)<([^>]+)>\s*<([^>]+)>$/) {
>> +	    my $real_name = $1;
>> +	    my $real_address = $2;
>> +	    my $wrong_address = $3;
>> +
>> +	    $real_name =~ s/\s+$//;
>> +	    ($real_name, $real_address) =
>> +		parse_email("$real_name <$real_address>");
>> +	    $ignoredmailmap->{$real_address} = 1;
>> +	}
>> +    }
>> +    close($ignoredmailmap_file);
>> +}
>> +
>>  ## use the filenames on the command line or find the filenames in the patchfiles
>>  
>>  my @files = ();
>> @@ -1074,6 +1120,10 @@ sub push_email_address {
>>      if ($address eq "") {
>>  	return 0;
>>      }
>> +    if (exists $ignoredmailmap->{$address}) {
>> +        #warn("Ignoring address: '" . $address . "'\n");
>> +        return 0;
>> +    }
>>  
>>      if (!$email_remove_duplicates) {
>>  	push(@email_to, [format_email($name, $address, $email_usename), $role]);
>>
> 
> 

