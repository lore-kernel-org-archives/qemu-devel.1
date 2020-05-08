Return-Path: <SRS0=NBT7=6W=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.9 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLACK autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4917C38A2A
	for <qemu-devel@archiver.kernel.org>; Fri,  8 May 2020 08:04:31 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7F79F207DD
	for <qemu-devel@archiver.kernel.org>; Fri,  8 May 2020 08:04:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JZjVc0zr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7F79F207DD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36394 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jWxzi-0003c5-OB
	for qemu-devel@archiver.kernel.org; Fri, 08 May 2020 04:04:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42218)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1jWxyv-00030R-Vf
 for qemu-devel@nongnu.org; Fri, 08 May 2020 04:03:41 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:39350
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1jWxyt-0005jk-KQ
 for qemu-devel@nongnu.org; Fri, 08 May 2020 04:03:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1588925018;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=0Bax9nR8cg/d6UliQhNebvDqtE1Yo3CgNVTbDeNVvyA=;
 b=JZjVc0zrrLixbpaATtpqOURfNrIL1kZajicDJPseiZfi4fsWW9DrrcTMmzXPQQ5BnKd/QC
 KxJM/Ue2yR5V503C9oX1o+pGTZy3mBmQ7xgI+9NmvdB0aa72rw3s78jd75xWAfvyLi0wsU
 UGYGzUYwg8hhML5Xr+YB1/8cuEISByM=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-444--GOEBp3MNuOzjIox5109jw-1; Fri, 08 May 2020 04:03:37 -0400
X-MC-Unique: -GOEBp3MNuOzjIox5109jw-1
Received: by mail-wm1-f70.google.com with SMTP id h6so4811824wmi.7
 for <qemu-devel@nongnu.org>; Fri, 08 May 2020 01:03:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:in-reply-to:references
 :user-agent:reply-to:date:message-id:mime-version
 :content-transfer-encoding;
 bh=0Bax9nR8cg/d6UliQhNebvDqtE1Yo3CgNVTbDeNVvyA=;
 b=Q10ZsSXNh9KmuLmpGV6r53c0HVgEWnIhq929Ww54+1aj9MJHkgeJ5u3Ha3E8dVjlBn
 nIRdwYe04dPTg0wCnE06cLJ9R8RpK3SuFpFvuiQhDSewQbI0/yZqwo6LdXfoDTm3dp/Y
 oYrgYCDbFQAjaQJvYzy73OROCbCxoAusZrBYy0hI41W9gHod+gWUt2bDTmz3cclbcvnb
 RpBM+i59+9vfMXf2XlgUTQ+1Clfk1CQhmEyLA1V9LqCPK0qc7AZOwbFyaVbh/SNoWOyE
 z3Mq3ld193zu1CnSGWWvdZNrHmVRg3sPb+J/NbixqDUeVhBnPXIQOUinikIEDoK1axu0
 J+SA==
X-Gm-Message-State: AGi0Pubw+fKU0iZVZlNWdJgcI9N1VeAL7IikjRpB4QJB0Ul1eqcwGFHY
 MMjb9Cz1tZ/EhwdtJ3HFLMRKHEIjhFV8eHhdaFvbcZ35DMO01V+6pu1f3icEgQu1jcQvKQtdmbw
 C7s8G++I4WQOlHQE=
X-Received: by 2002:adf:fccd:: with SMTP id f13mr1503951wrs.386.1588925015546; 
 Fri, 08 May 2020 01:03:35 -0700 (PDT)
X-Google-Smtp-Source: APiQypLMT+dtHBorN8AhWjT5Gp1Kf69qs5b/8ap0xyafE0nCALekGOmYNQEhZ7aAu08EjLOAeFupdQ==
X-Received: by 2002:adf:fccd:: with SMTP id f13mr1503907wrs.386.1588925015243; 
 Fri, 08 May 2020 01:03:35 -0700 (PDT)
Received: from localhost (trasno.trasno.org. [83.165.45.250])
 by smtp.gmail.com with ESMTPSA id t4sm1709351wri.54.2020.05.08.01.03.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 08 May 2020 01:03:33 -0700 (PDT)
From: Juan Quintela <quintela@redhat.com>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Subject: Re: [PATCH 05/10] exec: Move qemu_minrampagesize/qemu_maxrampagesize
 to 'qemu-common.h'
In-Reply-To: <20200507173958.25894-6-philmd@redhat.com> ("Philippe
 =?utf-8?Q?Mathieu-Daud=C3=A9=22's?= message of "Thu, 7 May 2020 19:39:53
 +0200")
References: <20200507173958.25894-1-philmd@redhat.com>
 <20200507173958.25894-6-philmd@redhat.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
Date: Fri, 08 May 2020 10:03:32 +0200
Message-ID: <87mu6ig8ff.fsf@secure.mitica>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=205.139.110.61; envelope-from=quintela@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/08 02:25:25
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Reply-To: quintela@redhat.com
Cc: Kevin Wolf <kwolf@redhat.com>, Peter Maydell <peter.maydell@linaro.org>,
 Cornelia Huck <cohuck@redhat.com>,
 Alex Williamson <alex.williamson@redhat.com>, qemu-block@nongnu.org,
 David Hildenbrand <david@redhat.com>, Alexey Kardashevskiy <aik@ozlabs.ru>,
 "Michael S. Tsirkin" <mst@redhat.com>, qemu-devel@nongnu.org,
 Max Reitz <mreitz@redhat.com>, Halil Pasic <pasic@linux.ibm.com>,
 Christian Borntraeger <borntraeger@de.ibm.com>, qemu-s390x@nongnu.org,
 qemu-ppc@nongnu.org, Keith Busch <kbusch@kernel.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
 David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com> wrote:
> Move these generic functions to a more common place, with other
> functions related to host page size. Document a little.
>
> Cc: Alexey Kardashevskiy <aik@ozlabs.ru>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>

Reviewed-by: Juan Quintela <quintela@redhat.com>


